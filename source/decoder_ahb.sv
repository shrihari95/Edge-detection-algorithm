// $Id: $
// File name:   decoder_ahb.sv
// Created:     3/22/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Decoder for AHB
module decoder_ahb
(
	input wire HCLK, 
	input wire HRESETn, 
	input wire decode_size_enable, 
	input wire decode_source_enable, 
	input wire decode_dest_enable, 
	input wire [31:0] HWDATA, 
	input wire [31:0] HADDR, 
	output reg [15:0] length, 
	output reg [15:0] width, 
	output reg [31:0] source_addr, 
	output reg [31:0] dest_addr
);
	reg [15:0] next_length;
	reg [15:0] next_width;
	reg [31:0] next_source_addr;
	reg [31:0] next_dest_addr;

	always_ff @ (posedge HCLK, negedge HRESETn)
	begin
		if (HRESETn == 0) begin
			length <= 0;
			width <= 0;
			source_addr <= 0;
			dest_addr <= 0;
		end
		else begin
			length <= next_length;
			width <= next_width;
			source_addr <= next_source_addr;
			dest_addr <= next_dest_addr;
		end
	end

	always_comb
	begin
		next_length = length;
		next_width = width;
		next_source_addr = source_addr;
		next_dest_addr = dest_addr;
		if (decode_size_enable) begin
			next_length = HWDATA[31:16];
			next_width = HWDATA[15:0];
		end
		else if (decode_source_enable) begin
			next_source_addr = HADDR;
			next_dest_addr = dest_addr;
		end
		else if (decode_dest_enable) begin
			next_dest_addr = HADDR;
			next_source_addr = source_addr;
		end
		else begin
			next_length = length;
			next_width = width;
			next_source_addr = source_addr;
			next_dest_addr = dest_addr;
		end
	end
endmodule
