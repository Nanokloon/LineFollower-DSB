module blinking_led (
    input  logic clk,
    input  logic rst,
    input  logic short,
    output logic led
  );

  logic [26:0] count;
  logic led_long, led_short;

  // up-counter 
  // resets itself every 100 million clock cycles (1 sec with a 100 MHz clock)
  always_ff @(posedge clk) begin
    if (rst)
      count <= 0;
    else
      if (count >= 100_000_000 - 1)
        count <= 0;
      else
        count <= count + 1;
  end

  // derive 0.5 sec and 0.25 sec pulses from counter
  assign led_long  = (count < 50_000_000);
  assign led_short = (count < 25_000_000);
  
  // choose which pulse to display on LED based on signal "short"
  assign led = short ? led_short : led_long;

endmodule