// $Id: $
// File name:   tb_test_pipelining_test.sv
// Created:     3/31/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for testing pipelining
`timescale 1ns / 10ps

module tb_pipelining_test();
	localparam CLK_PERIOD = 10;
	reg tb_clk;
	reg tb_n_rst;
	reg tb_increment_enable;
	reg tb_multiply_enable;
	reg [3:0] tb_a;
	reg [3:0] tb_b;
	reg [8:0] tb_e;

	pipelining_test DUT
	(
		.clk(tb_clk), 
		.n_rst(tb_n_rst), 
		.increment_enable(tb_increment_enable), 
		.multiply_enable(tb_multiply_enable), 
		.a(tb_a), 
		.b(tb_b), 
		.e(tb_e)
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
		tb_increment_enable = 0;
		tb_multiply_enable = 0;
		tb_a = 2;
		tb_b = 4;
		tb_n_rst = 0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_n_rst = 1;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_n_rst = 1;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_increment_enable = 1;
		@(posedge tb_clk);
		//tb_increment_enable = 0;
		//@(posedge tb_clk);
		tb_multiply_enable = 1;
		@(posedge tb_clk);

		tb_a = 5;
		tb_b = 3;
		@(posedge tb_clk);
		@(posedge tb_clk);

		tb_a = 2;
		tb_b = 10;
		@(posedge tb_clk);
		@(posedge tb_clk);

	end
endmodule
