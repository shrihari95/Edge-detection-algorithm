// $Id: $
// File name:   tb_address_update_w.sv
// Created:     4/13/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for Address Update Register (WRITE)
`timescale 1ns / 10ps

module tb_address_update_w();
	localparam CLK_PERIOD = 10;
	reg tb_HCLK;
	reg tb_HRESETn;
	reg [1:0] tb_status;
	reg [15:0] tb_length;
	reg [15:0] tb_width;
	reg [31:0] tb_addr;
	reg tb_addr_update_enable_w;
	reg tb_plus4_r
	reg [31:0] tb_curr_addr;

	address_update_w DUT
	(
		.HCLK(tb_HCLK), 
		.HRESETn(tb_HRESETn), 
		.status(tb_status), 
		.length(tb_length), 
		.width(tb_width), 
		.addr(tb_addr), 
		.addr_update_enable_w(tb_addr_update_enable_w), 
		.plus4_r(tb_plus4_r), 
		.curr_addr(tb_curr_addr)
	);

	// Generate Clock
	always
	begin
		tb_HCLK = 1'b0;
		#(CLK_PERIOD / 2);
		tb_HCLK = 1'b1;
		#(CLK_PERIOD / 2);
	end

	initial
	begin
		tb_length = 5;
		tb_width = 2;
		tb_addr = 0;
		tb_addr_update_enable_w = 0;
		tb_status = 2'b00;
		tb_HRESETn = 1;
		@(posedge tb_HCLK);
		tb_HRESETn = 0;
		@(posedge tb_HCLK);
		tb_HRESETn = 1;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_status = 2'b11;
		tb_addr_update_enable_w = 1;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_status = 2'b00;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_status = 2'b11;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_addr_update_enable_w = 0;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_addr_update_enable_w = 1;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_addr_update_enable_w = 0;
	end
endmodule
