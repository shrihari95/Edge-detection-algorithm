// $Id: $
// File name:   tb_four_8bits_to_32bits.sv
// Created:     3/21/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for testing 4*8 to 1*32
`timescale 1ns / 10ps

module tb_four_8bits_to_32bits();
	localparam CLK_PERIOD = 10;
	reg tb_clk;
	reg tb_n_rst;
	reg tb_shift_enable;
	reg [7:0] tb_bit_in_8;
	reg [31:0] tb_bit_out_32;

	four_8bits_to_32bits DUT_FOUR_8_TO_ONE_32
	(
		.clk(tb_clk), 
		.n_rst(tb_n_rst), 
		.shift_enable(tb_shift_enable), 
		.bit_in_8(tb_bit_in_8), 
		.bit_out_32(tb_bit_out_32)
	);

	// Generate clock
	always begin
	tb_clk = 1'b0;
	#(CLK_PERIOD / 2);
	tb_clk = 1'b1;
	#(CLK_PERIOD / 2);
	end

	initial
	begin
		tb_n_rst = 0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_n_rst = 1;
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_shift_enable = 1;
		@(posedge tb_clk);

		tb_bit_in_8 = 8'h25;
		//@(posedge tb_clk);

		tb_shift_enable = 0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);

		tb_shift_enable = 1;
		@(posedge tb_clk);

		tb_bit_in_8 = 8'h32;
		//@(posedge tb_clk);

		tb_shift_enable = 0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);

		tb_shift_enable = 1;
		@(posedge tb_clk);

		tb_bit_in_8 = 8'h64;
		//@(posedge tb_clk);

		tb_shift_enable = 0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);

		tb_shift_enable = 1;
		@(posedge tb_clk);

		tb_bit_in_8 = 8'h85;
		//@(posedge tb_clk);

		tb_shift_enable = 0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_shift_enable = 1;
		@(posedge tb_clk);
		tb_shift_enable = 0;
		@(posedge tb_clk);

	end
endmodule
