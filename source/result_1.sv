// $Id: $
// File name:  result_1.sv
// Created:     3/16/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Add and Comparing with threshold to determine edge or not

module result_1(
input reg [10:0]gx_out_1,
input reg [10:0]gy_out_1,
output byte final_out_1
);
//byte threshold;
//assign threshold = 8'd150;
//assign g_mag_2 = gx_out_2 + gy_out_2;
reg [10:0] abs_gx_out_1;
reg [10:0] abs_gy_out_1;
reg [10:0] sum;
always_comb
begin
	abs_gx_out_1 = gx_out_1[10] ? ~gx_out_1 + 1 : gx_out_1;
	abs_gy_out_1 = gy_out_1[10] ? ~gy_out_1 + 1 : gy_out_1;
	sum = abs_gx_out_1 + abs_gy_out_1;
	if(sum > 255)
		final_out_1 = 255;
	else
		final_out_1 = sum;
end
endmodule
