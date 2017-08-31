// $Id: $
// File name:   tb_fill_in_buffer.sv
// Created:     4/1/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for filling in buffer
`timescale 1ns / 10ps

module tb_fill_in_buffer();
	localparam CLK_PERIOD = 10;
	reg tb_clk;
	reg tb_n_rst;
	reg tb_shift_enable;
	reg tb_buffer_clear;
	byte tb_read_data;
	reg [11:0][7:0] tb_data_buffer;
	reg tb_buffer_full;
	reg tb_buffer_empty;

	fill_in_buffer DUT
	(
		.clk(tb_clk), 
		.n_rst(tb_n_rst), 
		.shift_enable(tb_shift_enable), 
		.buffer_clear(tb_buffer_clear), 
		.read_data(tb_read_data), 
		.data_buffer(tb_data_buffer), 
		.buffer_full(tb_buffer_full), 
		.buffer_empty(tb_buffer_empty)
	);

	// Generate Clock
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end

	initial
	begin
		tb_shift_enable = 0;
		tb_n_rst = 1;
		tb_buffer_clear = 0;
		@(posedge tb_clk);
		tb_n_rst = 0;
		@(posedge tb_clk);
		tb_n_rst = 1;
		@(posedge tb_clk);
		tb_shift_enable = 1;
		tb_read_data = 8'h2A;
		@(posedge tb_clk);
		tb_read_data = 8'h32;
		@(posedge tb_clk);
		tb_read_data = 8'h64;
		@(posedge tb_clk);
		tb_read_data = 8'h85;
		@(posedge tb_clk);
		tb_read_data = 8'h45;
		@(posedge tb_clk);
		tb_read_data = 8'hE1;
		@(posedge tb_clk);
		tb_read_data = 8'h76;
		@(posedge tb_clk);
		tb_read_data = 8'h40;
		@(posedge tb_clk);
		tb_read_data = 8'h23;
		@(posedge tb_clk);
		tb_read_data = 8'hA8;
		@(posedge tb_clk);
		tb_read_data = 8'h4F;
		@(posedge tb_clk);
		tb_read_data = 8'h9D;
		@(posedge tb_clk);
		tb_read_data = 8'h79;
		@(posedge tb_clk);
		tb_shift_enable = 0;	
		@(posedge tb_clk);
		tb_read_data = 8'h10;
		@(posedge tb_clk);
		tb_buffer_clear = 1;
		@(posedge tb_clk);
		tb_buffer_clear = 0;
		@(posedge tb_clk);
	end
endmodule
