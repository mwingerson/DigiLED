`timescale 1ns / 1ps

module led_driver #(
	parameter number_of_leds = 5,
	parameter time_to_delay = 2000
) (
    input clk,      //expecting 100MHz clock
    input enable,
    input [23:0] rgb_data,
    output read_data,   //flag gives 130 clock cycles before data is needed
    output [($clog2(number_of_leds))-1:0] led_num,
    output bitstream
    );
      
//////internal variables//////
reg [23:0] internal_color = 24'h000000; //stored in GRB  - internal_color <= {rgb_data[15:8], rgb_data[23:16], rgb_data[7:0]};

//frame divider variables
integer frame_counter_div = 0;
localparam frame_counter_div_max = 130 - 1;
wire frame_counter_div_flag;

//frame counter variables
integer frame_counter = 0;
localparam frame_counter_max = 24 - 1;

//0 PWM counter variables
localparam PMW0_counter_max = 35;
localparam PMW1_counter_max = 70;
wire PWM0_out;
wire PWM1_out;

//state machine variables
reg [($clog2(number_of_leds))-1:0] led_counter = 0;
//integer led_counter = 0;
reg [($clog2(time_to_delay))-1:0] delay_counter = 0;
//integer delay_counter = 0;

localparam BITBANG0_ST   = 2'b00;
localparam BITBANG1_ST   = 2'b01;
localparam BITBANG2_ST   = 2'b10;
localparam DELAY_ST      = 2'b11;

reg [1:0] state = BITBANG0_ST;
reg delay_done_flag = 0;
wire internal_reset;

//assign the PWM signal from PWM1 or PWM0 dependent on the
//whether current indexed bit is a 1 or 0
//assign bitstream = (internal_color[23-frame_counter] == 1'b1) ? PWM1_out : PWM0_out;
assign bitstream = (enable && internal_color[23-frame_counter]) ? PWM1_out : PWM0_out;
  
//////frame counter divider//////
always@ (posedge clk) begin
    if(frame_counter_div < frame_counter_div_max && !internal_reset && (state == BITBANG0_ST || state == BITBANG1_ST || state == BITBANG2_ST))
        frame_counter_div <= frame_counter_div + 1;
    else 
       frame_counter_div <= 0;
end

assign frame_counter_div_flag = (frame_counter_div == frame_counter_div_max) ? 1'b1 : 1'b0;

//////frame counter//////
always@ (posedge clk) begin
    if(frame_counter_div_flag == 1 && frame_counter < frame_counter_max && (state == BITBANG0_ST || state == BITBANG1_ST || state == BITBANG2_ST))begin
        frame_counter <= frame_counter + 1'b1;
    end
    else if(frame_counter_div_flag == 1)
        frame_counter <= 0;
    else
        frame_counter <= frame_counter;
end

//pwm assign statements
assign PWM0_out = (frame_counter_div < PMW0_counter_max && !internal_reset && (state == BITBANG0_ST || state == BITBANG1_ST || state == BITBANG2_ST)) ? 1'b1 : 1'b0;
assign PWM1_out = (frame_counter_div < PMW1_counter_max && !internal_reset && (state == BITBANG0_ST || state == BITBANG1_ST || state == BITBANG2_ST)) ? 1'b1 : 1'b0;

//state machine reset
assign internal_reset = (!enable || delay_done_flag);

//////color state machine//////
always@ (posedge clk or posedge internal_reset)
    if(internal_reset) begin
        state <= BITBANG0_ST;
        led_counter <= 0;
        end
    else
        case(state)     
            BITBANG0_ST : begin
                internal_color <= {rgb_data[15:8], rgb_data[23:16], rgb_data[7:0]};
                state <= BITBANG1_ST;
            end
            
            BITBANG1_ST : begin
                if(frame_counter_div_flag)  begin
                    state <= BITBANG2_ST;
                    led_counter <= led_counter + 1'b1;
                end
                else 
                    state <= BITBANG1_ST;
            end
            
            BITBANG2_ST : begin
                if(frame_counter != frame_counter_max && frame_counter_div_flag)
                    state <= BITBANG2_ST;
                     
                else if((led_counter < number_of_leds) && frame_counter_div_flag)begin
                    state <= BITBANG0_ST;
                    //led_counter <= led_counter + 1'b1;
                end
                
                else if(frame_counter_div_flag) begin
                    state <= DELAY_ST;
                                led_counter <= 0;
                    end
                else
                    state <= BITBANG2_ST;
            end
            
            DELAY_ST:;
         endcase 
            
//delay counter for color FSM
always@ (posedge clk)
    if(delay_counter < time_to_delay && state == DELAY_ST)
        delay_counter <= delay_counter + 1;
    else
        delay_counter <= 0;

always@ (posedge clk)
    if(state == DELAY_ST && delay_counter == time_to_delay)
        delay_done_flag <= 1;
    else if(state == BITBANG0_ST)
        delay_done_flag <= 0;
    else
        delay_done_flag <= delay_done_flag;

assign led_num = (led_counter < number_of_leds) ? led_counter : 0;
 
assign read_data = ((frame_counter == frame_counter_max-1)&&frame_counter_div_flag)? 1'b1 : 1'b0;
 
 
endmodule