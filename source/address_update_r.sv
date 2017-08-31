// $Id: $
// File name:   address_update_r.sv
// Created:     3/21/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Address Update (READ) of AHB
module address_update_r
(
	input wire HCLK, 
	input wire HRESETn, 
	input reg [15:0] length, 
	input reg [15:0] width, 
	input reg [31:0] addr, 
	input wire addr_update_enable_r, 
	output reg [31:0] curr_addr, 
	output reg plus4_r, 
	output wire end_of_image
);
	reg last_possible_row;
	reg [31:0] size;
	reg [31:0] offset_r;
	reg [31:0] next_offset_r;
	reg [31:0] row_count;
	reg [31:0] next_row_count;
	reg [31:0] column_count;
	reg [31:0] next_column_count;


	always_comb
	begin
		size = width * length;
	end

	//assign update_en_r = addr_update_enable_r && (status == 2'b10);

	flex_counter#(32) COLUMN_COUNTER
	(
		.clk(HCLK), 
		.n_rst(HRESETn), 
		.count_enable(addr_update_enable_r), 
		.rollover_val(length - 4), 
		.count_out(column_count), 
		.rollover_flag(plus4_r)
	);



	always_ff @ (posedge HCLK, negedge HRESETn)
	begin
		if (HRESETn == 0) begin
			offset_r <= 0;
			row_count <= 0;
		end
		else begin
			offset_r <= next_offset_r;
			row_count <= next_row_count;
		end
	end


	always_comb
	begin
		next_offset_r = offset_r;
		next_row_count = row_count;
		if (addr_update_enable_r) begin
			if (last_possible_row) begin
				next_offset_r = offset_r + 1;
				if (offset_r >= length * (width - 3) + (length - 4))
					next_offset_r = offset_r;
			end
			else begin
				if (plus4_r) begin
					next_offset_r = offset_r + 4;
					next_row_count = row_count + 1;
				end
				else
					next_offset_r = offset_r + 1;
			end
		end
		curr_addr = addr + offset_r;
	end
	assign end_of_image = (offset_r >= length * (width - 3) + (length - 4));
	assign last_possible_row = (row_count == width - 3);
endmodule
