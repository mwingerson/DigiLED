`timescale 1ns / 1ps

module HSV_to_RGB(
    input [31:0]hsv_data_in,
    output reg [23:0]rgb_data_out
    );

integer sat;
integer val;
integer chroma;

reg [15:0] hue;
//reg [15:0] chroma;
reg [7:0]m_num;

always @(*) begin
	hue <= hsv_data_in[31:16];
    sat <= hsv_data_in[15:8];
    val <= hsv_data_in[7:0];
    
	//chroma = sat * val
	//chroma <= (hsv_data_in[15:8]*hsv_data_in[7:0])>>8;
    chroma <= ((sat*val)>>8)+1;

	//m_num = value - chroma	
	m_num <= hsv_data_in[7:0]-chroma;
	
	//if value ==0 then color is 0
	if(hsv_data_in[7:0] == 0)
       rgb_data_out <= 0;

	else if(hue < 256) begin
		//Red=chroma+m_num-1
		//Green = (Hue*chroma)>>8 + m_num
		//Blue = m_num
		rgb_data_out[23:16] <= chroma+m_num-1;
		rgb_data_out[15:8]  <= ((hue*chroma)>>8) + m_num;
		rgb_data_out[7:0]   <= m_num;
	end

	else if(hue < 512) begin
		//Red=(((511-hue)*chroma)>>8)+m_num
		//Green=(chroma+m_num)-1
		//Blue = m_num
		rgb_data_out[23:16] <= (((511-hue)*chroma)>>8) + m_num;
		rgb_data_out[15:8]  <= chroma+m_num-1;
		rgb_data_out[7:0]   <= m_num;
	end

	else if(hue < 768) begin
		//Red=m)num
		//Green=(chroma+m_num)-1
		//Blue=(((Hue-512)*chroma)>>8)+m_num
		rgb_data_out[23:16] <= m_num;
		rgb_data_out[15:8]  <= chroma+m_num-1;
		rgb_data_out[7:0]   <= (((hue-512)*chroma)>>8) + m_num;
	end
	
	else if(hue < 1024) begin
		//Red=m_num
		//Green=(((1023-hue)*chroma)>>8)*m_num
		//Blue=m_num+chroma-1
		rgb_data_out[23:16] <= m_num;
		rgb_data_out[15:8]  <= (((1023-hue)*chroma)>>8) + m_num;
		rgb_data_out[7:0]   <= chroma+m_num-1;
	end
	
	else if(hue < 1280) begin
		//Red=((hue-1024)*chroma)>>8)+m_num
		//Green=m_num
		//Blue=m_num+chroma-1
		rgb_data_out[23:16] <= (((hue-1024)*chroma)>>8) + m_num;
		rgb_data_out[15:8]  <= m_num;
		rgb_data_out[7:0]   <= chroma+m_num-1;
	end
	
	else if(hue < 1536) begin
		//Red=m_num+chroma-1
		//Green=m_num
		//Blue=(((1535-hue)*chroma)>>8)+m_num
		rgb_data_out[23:16] <= chroma+m_num-1;
		rgb_data_out[15:8]  <= m_num;
		rgb_data_out[7:0]   <= (((1535-hue)*chroma)>>8) + m_num;
	end

	else	//error case
		rgb_data_out <= 0;
end

endmodule