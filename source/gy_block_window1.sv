// $Id: $
// File name:   gy_block.sv
// Created:     3/16/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: gy block for the calculation of gradient gy

module gy_block_window1(
    input wire clk, 
    input wire n_rst, 
    input wire unsigned [11:0][7:0] data_buffer,
    input wire enable_calc,
    output reg [10:0]gy_out_1
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
reg [10:0] next_gy_out_1;

always_ff @ (posedge clk, negedge n_rst)
begin
	if (n_rst == 0)
		gy_out_1 <= 0;
	else
		gy_out_1 <= next_gy_out_1;
end

always_comb
begin
	if(enable_calc == 1)begin
		//gy_out_1 = (a0*data_buffer[0]) + (a1*data_buffer[1]) + (a2*data_buffer[2]) + (a3*data_buffer[4]) + (a4*data_buffer[5]) + (a5*data_buffer[6]) + (a6*data_buffer[8]) + (a7*data_buffer[9]) + (a8*data_buffer[10]);
		x = (data_buffer[8]) + (data_buffer[9]);
		y = (data_buffer[9]) + (data_buffer[10]);
		z = data_buffer[0] + data_buffer[1];
		w = data_buffer[1] + data_buffer[2];
		sum = x-z;
		sum1 = y-w;
		next_gy_out_1 = sum + sum1;
		//gy_out_1 = (data_buffer[0]) + (data_buffer[1]) + (data_buffer[1]) + (data_buffer[2]) - data_buffer[8] - data_buffer[9] - data_buffer[9] - data_buffer[10];
		end
	else
		next_gy_out_1 = gy_out_1;
end
endmodule
