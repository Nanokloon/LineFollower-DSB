module controller 
   (input logic clk,
    input logic reset,

    input logic sensor_l,
    input logic sensor_m,
    input logic sensor_r,

    input logic [20:0] count_in,
    output logic count_reset,

    output logic motor_l_reset,
    output logic motor_l_direction,

    output logic motor_r_reset,
    output logic motor_r_direction);

    // actual FSM control
    typedef enum logic [2:0] { off, sharp_left, gentle_left, forward, gentle_right, sharp_right } controller_state;
    controller_state state,next_state;
    
    always_ff @(posedge clk) begin
        if(reset)begin
            state <= off;
            count_reset<=1;
        end
        else begin
            state <= next_state;
            count_reset<=0;
        end
    end
    
    //state logic
    always_comb begin
        case ({sensor_l,sensor_m,sensor_r})
            3'b000:
                next_state = forward;
            3'b001:
                next_state = gentle_left;
            3'b010:
                next_state = forward;
            3'b011:
                next_state = sharp_left;
            3'b100:
                next_state = gentle_right;
            3'b101:
                next_state = forward;
            3'b110:
                next_state = sharp_right;
            3'b111:
                next_state = forward;
        endcase
    end

    //output logic
    always_comb begin
        case(state)
            off:
                begin
                    motor_l_reset=1;
                    motor_r_reset=1;
                end
            forward:
                begin
                    motor_l_direction=1;
                    motor_r_direction=0;
                    motor_l_reset=0;
                    motor_r_reset=0;
                end
            gentle_left:
                begin
                    motor_l_direction=0;
                    motor_r_direction=0;
                    motor_l_reset=1;
                    motor_r_reset=0;
                end
            sharp_left:
                begin
                    motor_l_direction=0;
                    motor_r_direction=0;
                    motor_l_reset=0;
                    motor_r_reset=0;
                end
            gentle_right:
                begin
                    motor_l_direction=1;
                    motor_r_direction=0;
                    motor_l_reset=0;
                    motor_r_reset=1;
                end
            sharp_right:
                begin
                    motor_l_direction=1;
                    motor_r_direction=1;
                    motor_l_reset=0;
                    motor_r_reset=0;
                end
            default:
                begin
                    motor_l_reset=1;
                    motor_r_reset=1;
                end
        endcase
    end
endmodule
   
