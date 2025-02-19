module inputbuffer
   (input logic clk,
    input logic sensor_l_in,
    input logic sensor_m_in, 
    input logic sensor_r_in,
    output logic sensor_l_out,
    output logic sensor_m_out, 
    output logic sensor_r_out);

    logic [2:0] sensor_reg;
    logic buffer_l,buffer_m,buffer_r;
    
    always_ff @(posedge clk)begin
        sensor_reg <= {sensor_l_in,sensor_m_in,sensor_r_in};
    end
    
    always_ff @(posedge clk)begin
        {sensor_l_out,sensor_m_out,sensor_r_out} <= sensor_reg;
    end

    
    //always_ff @(posedge clk)begin
    //    buffer_l <= sensor_reg[0];
    //    buffer_m <= sensor_reg[1];
    //    buffer_r <= sensor_reg[2];
    //end

    //assign sensor_l_out = buffer_l;
    //assign sensor_m_out = buffer_m;
    //assign sensor_r_out = buffer_r;
endmodule
