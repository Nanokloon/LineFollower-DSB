
module motorcontrol 
   (input logic clk,
    input logic reset,
    input logic direction, 
    input logic [16:0] count_in,
    output logic pwm);
    
    typedef enum logic { motor_off, motor_cw, motor_ccw } motor_controller_state;
    motor_controller_state state,next_state;

    always_ff @(posedge clk)
        if (reset)
            state <= motor_off;
        else
            state <= next_state;
    
    always_comb //state logic
    begin
        case(state)
            motor_off:
            begin
                if(direction ==? 0)
                    next_state = motor_ccw;
                else
                    next_state = motor_cw;
            end
            motor_ccw:
            begin
                if(direction ==? 0)
                    next_state = motor_ccw;
                else
                    next_state = motor_cw;
            end
            motor_cw:
            begin
                if(direction ==? 0)
                    next_state = motor_ccw;
                else
                    next_state = motor_cw;
            end
        endcase
    end

    always_ff @(count_in)
    begin
    
    
    end


endmodule
