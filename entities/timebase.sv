module timebase 
   (input logic clk,
    input logic reset,
    output logic [20:0] count);
    
    logic [20:0] next_count;
    
    always_ff @(posedge clk)
    begin
        if(reset)
            count <= 0;
        else
            count <= next_count;
    end

    always_comb begin
    if(count==?2000000)
        next_count=0;
    else
        next_count=count+1;
    end

endmodule
