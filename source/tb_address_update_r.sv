// $Id: $
// File name:   tb_address_update_r.sv
// Created:     3/22/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for ADDRESS_UPDATE (READ) for AHB
`timescale 1ns / 10ps

module tb_address_update_r();
	localparam CLK_PERIOD = 10;

	reg tb_HCLK;
	reg tb_HRESETn;
	reg [1:0] tb_status;
	reg [15:0] tb_length;
	reg [15:0] tb_width;
	reg [31:0] tb_addr;
	reg tb_addr_update_enable_r;
	reg [31:0] tb_curr_addr;
	reg tb_plus4_r;
	reg tb_end_of_image;

	address_update_r DUT_ADDRESS_UPDATE
	(
		.HCLK(tb_HCLK), 
		.HRESETn(tb_HRESETn), 
		.status(tb_status), 
		.length(tb_length), 
		.width(tb_width), 
		.addr(tb_addr), 
		.addr_update_enable_r(tb_addr_update_enable_r), 
		.curr_addr(tb_curr_addr), 
		.plus4_r(tb_plus4_r), 
		.end_of_image(tb_end_of_image)
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
		tb_length = 10;
		tb_width = 7;
		tb_addr = 0;
		tb_addr_update_enable_r = 0;
		tb_HRESETn = 0;
		tb_status = 2'b00;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);
		tb_HRESETn = 1;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);


		tb_status = 2'b10;
		tb_addr_update_enable_r = 1; //0
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //1
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //2
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //3
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_status = 2'b00;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_status = 2'b10;
		@ (posedge tb_HCLK);


		tb_addr_update_enable_r = 1; //4
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1;  //5
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //6
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //10
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //11
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1;
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1;
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1;
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1;
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //20
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //21
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //22
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //23
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //24
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //25
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //26
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //30
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //31
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //32
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //33
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //34
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //35
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //36
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //40
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //41
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //42
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //43
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //44
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //45
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //46
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //46 (50 is wrong)
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //46
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //46
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //46
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);

		tb_addr_update_enable_r = 1; //46
		@ (posedge tb_HCLK);
		tb_addr_update_enable_r = 0;
		@ (posedge tb_HCLK);
		@ (posedge tb_HCLK);
	end
endmodule
