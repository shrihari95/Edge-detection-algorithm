// $Id: $
// File name:   tb_ahb_slave.sv
// Created:     4/13/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: AHB Slave Test bench
`timescale 1ns / 10ps

module tb_ahb_slave();
	localparam CLK_PERIOD = 40;
	reg tb_HCLK;
	reg tb_HRESETn;
	reg tb_HREADY;
	reg tb_HWRITE;
	reg [31:0] tb_HWDATA;
	reg [31:0] tb_HADDR;
	reg [2:0] tb_status;
	reg [15:0] tb_length;
	reg [15:0] tb_width;
	reg [31:0] tb_source_addr;
	reg [31:0] tb_dest_addr;
	reg tb_read_enable;
	reg tb_write_enable;

	ahb_slave DUT_AHB_SLAVE
	(
		.HCLK(tb_HCLK), 
		.HRESETn(tb_HRESETn), 
		.HREADY(tb_HREADY), 
		.HWRITE(tb_HWRITE), 
		.HWDATA(tb_HWDATA), 
		.HADDR(tb_HADDR), 
		.status(tb_status), 
		.length(tb_length), 
		.width(tb_width), 
		.source_addr(tb_source_addr), 
		.dest_addr(tb_dest_addr), 
		.read_enable(tb_read_enable), 
		.write_enable(tb_write_enable)
	);

	// Generate clock
	always
	begin
		tb_HCLK = 1'b1;
		#(CLK_PERIOD / 2);
		tb_HCLK = 1'b0;
		#(CLK_PERIOD / 2);
	end

	initial
	begin
		tb_HRESETn = 1;
		tb_HWDATA = 32'h10000100;
		tb_HADDR = 32'h00100000;
		tb_HWRITE = 0;
		tb_HREADY = 0;
		@(posedge tb_HCLK);
		tb_HRESETn = 0;
		@(posedge tb_HCLK);
		tb_HRESETn = 1;
		@(posedge tb_HCLK);

		tb_HREADY = 1;
		while (tb_status != 3'b010)
			@(posedge tb_HCLK);
		tb_HADDR = 32'h00200000;
		@(posedge tb_HCLK);
		tb_HWRITE = 1;
		@(posedge tb_HCLK);
		tb_HWRITE = 0;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		/*@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_HREADY = 0;
		tb_HWRITE = 1;
		@(posedge tb_HCLK);
		tb_HADDR = 32'h00200000;
		@(posedge tb_HCLK);
		tb_HREADY = 1;
		@(posedge tb_HCLK);*/
	end
endmodule
