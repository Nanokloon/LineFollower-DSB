`timescale 1 ns/ 1 ps

module blinking_led_tb ();
  
  logic clk = 1'b1, rst = 1'b1, short = 1'b0, led;
  
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    #20         rst   = 1'b0;
    #1000000000 short = 1'b1;
  end

  blinking_led dut(.*);

endmodule