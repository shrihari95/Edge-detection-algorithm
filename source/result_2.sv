// $Id: $
// File name:   result2.sv
// Created:     4/5/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Add and Comparing with threshold to determine edge or not

module result_2(
input reg [10:0]gx_out_2,
input reg [10:0]gy_out_2,
output byte final_out_2
);
//byte threshold;
//byte g_mag_2;
//assign threshold = 8'd150;
//assign g_mag_2 = gx_out_2 + gy_out_2;
reg [10:0] abs_gx_out_2;
reg [10:0] abs_gy_out_2;
reg [10:0] sum;
always_comb
begin
	abs_gx_out_2 = gx_out_2[10] ? ~gx_out_2 + 1 : gx_out_2;
	abs_gy_out_2 = gy_out_2[10] ? ~gy_out_2 + 1 : gy_out_2;
	sum = abs_gx_out_2 + abs_gy_out_2;	
	if(sum > 255)
		final_out_2 = 255;
	else
		final_out_2 = sum;
end
endmodule
