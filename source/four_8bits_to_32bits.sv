// $Id: $
// File name:   four_8bits_to_32bits.sv
// Created:     3/21/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Four 8-bit array to one 32-bit array
module four_8bits_to_32bits
(
	input wire clk, 
	input wire n_rst, 
	input wire shift_enable, 
	input wire [7:0] bit_in_8, 
	output reg [31:0] bit_out_32
);
	reg [31:0] next_bit_out_32;
	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == 0)
			bit_out_32 <= '1;
		else
			bit_out_32 <= next_bit_out_32;
	end

	always_comb
	begin
		next_bit_out_32 = bit_out_32;
		if (shift_enable) begin
			next_bit_out_32[31:8] = bit_out_32[23:0];
			next_bit_out_32[7:0] = bit_in_8;
		end
	end
endmodule
