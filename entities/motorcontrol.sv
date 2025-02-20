
module motorcontrol 
   (input logic clk,
    input logic reset,
    input logic direction, 
    input logic [20:0] count_in,
    output logic pwm);
    
//    typedef enum logic [1:0] { motor_off, motor_cw, motor_ccw } motor_controller_state;
//    motor_controller_state state,next_state;
//
//    always_ff @(posedge clk)
//        if (reset)
//            state <= motor_off;
//        else
//            state <= next_state;
//    
//    always_comb //state logic
//    begin
//        if(direction ==? 0)
//            next_state = motor_ccw;
//        else
//            next_state = motor_cw;
//    end
//    
//    always_comb //PWM logic
//    begin
//        case(state)
//            motor_off:
//                pwm=0;
//            motor_ccw:
//            begin
//                if(count_in <= 100000)
//                    pwm=1;
//                else
//                    pwm=0;
//            end
//            motor_cw:
//            begin
//                if(count_in <= 200000 )
//                    pwm=1;
//                else
//                    pwm=0;
//            end
//        endcase
//    
//    end

    typedef enum logic { pwm_off, pwm_on } motor_controller_state;
    motor_controller_state state,next_state;
    always_ff @(posedge clk) begin
        if(reset)
            state<=pwm_off;
        else
            state<= next_state;
    end

    always_comb begin
        case(state)
            pwm_off:
            begin
                pwm=0;
                if(count_in ==? 0) begin
                    next_state=pwm_on;
                end
            end
            pwm_on:
            begin
                pwm=1;
                if((direction ==? 0) && (count_in >= 100000)) begin //CCW
                    next_state=pwm_off;
                end
                else if((direction ==? 1) && (count_in >= 200000)) begin
                    next_state=pwm_off;
                end
                else
                    next_state=pwm_on;
            end
        endcase
    end
endmodule
