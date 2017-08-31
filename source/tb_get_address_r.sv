// $Id: $
// File name:   tb_get_address_r.sv
// Created:     3/22/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for GET ADDRESS (READ) for AHB
`timescale 1ns / 10ps

module tb_get_address_r();
	localparam CLK_PERIOD = 10;
	reg tb_HCLK;
	reg tb_HRESETn;
	reg [1:0] tb_status;
	reg tb_addr_enable_r;
	reg [31:0] tb_curr_addr;
	reg [15:0] tb_length;
	reg [15:0] tb_width;
	reg [31:0] tb_start_addr_r;
	reg tb_transfer_addr_complete_r;

	get_address_r DUT_GET_ADDRESS_R
	(
		.HCLK(tb_HCLK), 
		.HRESETn(tb_HRESETn), 
		.addr_enable_r(tb_addr_enable_r), 
		.curr_addr(tb_curr_addr), 
		.length(tb_length), 
		.width(tb_width), 
		.start_addr_r(tb_start_addr_r), 
		.transfer_addr_complete_r(tb_transfer_addr_complete_r)
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
		tb_curr_addr = 0;
		tb_length = 6;
		tb_width = 7;
		tb_addr_enable_r = 0;
		tb_HRESETn = 0;
		tb_status = 2'b00;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);
		tb_HRESETn = 1;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_enable_r = 1;
		tb_status = 2'b10;
		@ (posedge tb_HCLK);
		tb_addr_enable_r = 0;
		@ (posedge tb_HCLK);
		tb_addr_enable_r = 1;
		@ (posedge tb_HCLK);
		tb_addr_enable_r = 0;
		@ (posedge tb_HCLK);
		tb_status = 2'b00;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);
		tb_status = 2'b10;
		@ (posedge tb_HCLK);
		tb_addr_enable_r = 1;
		@ (posedge tb_HCLK);
		tb_addr_enable_r = 0;
		@ (posedge tb_HCLK);
		tb_curr_addr = 1;
		@ (posedge tb_HCLK);

		tb_addr_enable_r = 1;
		@ (posedge tb_HCLK);
		tb_addr_enable_r = 0;
		@ (posedge tb_HCLK);
		tb_addr_enable_r = 1;
		@ (posedge tb_HCLK);
		tb_addr_enable_r = 0;
		@ (posedge tb_HCLK);
		tb_addr_enable_r = 1;
		@ (posedge tb_HCLK);
		tb_addr_enable_r = 0;
		@ (posedge tb_HCLK);
		
	end
endmodule
