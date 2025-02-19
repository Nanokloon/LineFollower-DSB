module robot
   (input logic clk,
    input logic reset,

    input logic sensor_l_in,
    input logic sensor_m_in,
    input logic sensor_r_in,

    output logic motor_l_pwm,
    output logic motor_r_pwm);
    
    //timebase
    logic [20:0] counter;
    logic counter_reset;
    logic direction_l,direction_r,rst_l,rst_r;
    logic sensor_l,sensor_m,sensor_r;

    timebase tb(.clk(clk),.reset(counter_reset),.count(counter));
    
    //input buffer
    inputbuffer ib(.clk(clk),
                   .sensor_l_in(sensor_l_in),.sensor_m_in(sensor_m_in),.sensor_r_in(sensor_r_in),
                   .sensor_l_out(sensor_l),.sensor_m_out(sensor_m),.sensor_r_out(sensor_r));

    //controller
    controller ctrl(.clk(clk),.reset(reset),
                    .sensor_l(sensor_l),.sensor_m(sensor_m),.sensor_r(sensor_r),
                    .count_in(counter),.count_reset(counter_reset),
                    .motor_l_reset(rst_l),.motor_l_direction(direction_l),
                    .motor_r_reset(rst_r),.motor_r_direction(direction_r));

    // motor control
    motorcontrol mc_l (.clk(clk),.reset(rst_l),.direction(direction_l),.count_in(counter),.pwm(motor_l_pwm));
    motorcontrol mc_r (.clk(clk),.reset(rst_r),.direction(direction_r),.count_in(counter),.pwm(motor_r_pwm));
endmodule
