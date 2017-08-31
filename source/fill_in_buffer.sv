// $Id: $
// File name:   fill_in_buffer.sv
// Created:     4/1/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Fill in the buffer
module fill_in_buffer
(
	input wire clk, 
	input wire n_rst, 
	input wire shift_enable, 
	input wire buffer_clear, 
	input byte read_data, 
	output reg unsigned [11:0][7:0] data_buffer, 
	output wire buffer_full, 
	output reg buffer_empty
);
	reg [31:0] pixel_count;
	reg [7:0] next_data_buffer;

	flex_counter#(32) PIXEL_COUNTER
	(
		.clk(clk), 
		.n_rst(n_rst), 
		.clear(buffer_clear), 
		.count_enable(shift_enable), 
		.rollover_val(12), 
		.count_out(pixel_count), 
		.rollover_flag(buffer_full)
	);

	


	//assign buffer_empty = (pixel_count == 0 && !shift_enable);
	//assign buffer_full = (pixel_count == 11);

	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == 0) begin
			data_buffer[11:0] <= 0;
			buffer_empty = 1;
		end
		else if (buffer_clear) begin
			data_buffer[11:0] <= 0;
			buffer_empty = 1;
		end
		else
			data_buffer[pixel_count] <= next_data_buffer;
	end

	always_comb
	begin
		next_data_buffer = data_buffer[pixel_count];
		if (shift_enable)
			next_data_buffer = read_data;
	end
endmodule
