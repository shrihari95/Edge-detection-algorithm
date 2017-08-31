// $Id: $
// File name:   gy_block_window2.sv
// Created:     4/5/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: gy block for 
module gy_block_window2(
input wire clk, 
input wire n_rst, 
 input wire unsigned [11:0][7:0] data_buffer,
input wire enable_calc,
 output reg [10:0]gy_out_2
);
localparam a0 = 1;
localparam a1 = 2;
localparam a2 = 1;
localparam a3 = 0;
localparam a4 = 0;
localparam a5 = 0;
localparam a6 = -1;
localparam a7 = -2;
localparam a8 = -1;

reg [9:0]x;
reg [9:0]y;
reg [9:0]z;
reg [9:0]w;
reg [10:0]sum;
reg [10:0]sum1;
reg [10:0] next_gy_out_2;

always_ff @ (posedge clk, negedge n_rst)
begin
	if (n_rst == 0)
		gy_out_2 <= 0;
	else
		gy_out_2 <= next_gy_out_2;
end

always_comb
begin
	if(enable_calc == 1)begin
		x = (data_buffer[9]) + (data_buffer[10]);
		y = (data_buffer[10]) + (data_buffer[11]);
		z = data_buffer[1] + data_buffer[2];
		w = data_buffer[2] + data_buffer[3];
		sum = x-z;
		sum1 = y-w;
		next_gy_out_2 = sum + sum1;
		//gy_out_2 = (a0*data_buffer[1]) + (a1*data_buffer[2]) + (a2*data_buffer[3]) + (a3*data_buffer[5]) + (a4*data_buffer[6]) + (a5*data_buffer[7]) + (a6*data_buffer[9]) + (a7*data_buffer[10]) + (a8*data_buffer[11]);
		end
	else
		next_gy_out_2 = gy_out_2;
end
endmodule
