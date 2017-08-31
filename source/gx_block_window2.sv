// $Id: $
// File name:   gx_block_window2.sv
// Created:     3/23/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Gx calculation block for the second window


module gx_block_window2(
input wire clk, 
input wire n_rst, 
input reg unsigned [11:0][7:0]data_buffer,
input wire enable_calc,
output reg [10:0]gx_out_2
);
localparam a0 = -1;
localparam a1 = 0;
localparam a2 = 1;
localparam a3 = -2;
localparam a4 = 0;
localparam a5 = 2;
localparam a6 = -1;
localparam a7 = 0;
localparam a8 = 1;


reg [9:0]x;
reg [9:0]y;
reg [9:0]z;
reg [9:0]w;
reg [10:0]sum;
reg [10:0]sum1;
reg [10:0] next_gx_out_2;

always_ff @ (posedge clk, negedge n_rst)
begin
	if (n_rst == 0)
		gx_out_2 <= 0;
	else
		gx_out_2 <= next_gx_out_2;
end

always_comb
begin
	if(enable_calc == 1)begin
		x = data_buffer[3] + data_buffer[7];
		y = data_buffer[7] + data_buffer[11];
		z = (data_buffer[1]) + (data_buffer[5]);
		w = (data_buffer[5]) + (data_buffer[9]);
		sum = x-z;
		sum1 = y-w;
		next_gx_out_2 = sum + sum1;
		//gx_out_2 = (a0*data_buffer[1]) + (a1*data_buffer[2]) + (a2*data_buffer[3]) + (a3*data_buffer[5]) + (a4*data_buffer[6]) + (a5*data_buffer[7]) + (a6*data_buffer[9]) + (a7*data_buffer[10]) + (a8*data_buffer[11]);
		end
	else
		next_gx_out_2 = gx_out_2;
end
endmodule
