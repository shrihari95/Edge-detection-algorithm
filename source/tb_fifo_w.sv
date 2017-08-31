// $Id: $
// File name:   tb_fifo_w.sv
// Created:     3/22/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for FIFO (WRITE)
`timescale 1ns / 10ps

module tb_fifo_w();
	localparam CLK_PERIOD = 10;
	reg tb_HCLK;
	reg tb_HRESETn;
	reg tb_shift_enable;
	reg [7:0] tb_data_out_1;
	reg [7:0] tb_data_out_2;
	reg [31:0] tb_HWDATA;
	//reg tb_transfer_data_complete_w;

	fifo_w DUT_FIFO_W
	(
		.HCLK(tb_HCLK), 
		.HRESETn(tb_HRESETn), 
		.shift_enable(tb_shift_enable), 
		.data_out_1(tb_data_out_1), 
		.data_out_2(tb_data_out_2), 
		.HWDATA(tb_HWDATA)
		//.transfer_data_complete_w(tb_transfer_data_complete_w)
	);

	// Generate clock
	always begin
	tb_HCLK = 1'b0;
	#(CLK_PERIOD / 2);
	tb_HCLK = 1'b1;
	#(CLK_PERIOD / 2);
	end

	initial
	begin
		tb_shift_enable = 0;
		tb_HRESETn = 0;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_HRESETn = 1;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_data_out_1 = 8'h25;
		tb_data_out_2 = 8'h32;
		@(posedge tb_HCLK);
		tb_shift_enable = 1;
		@(posedge tb_HCLK);




		tb_shift_enable = 0;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);

		tb_data_out_1 = 8'h64;
		tb_data_out_2 = 8'h85;
		@(posedge tb_HCLK);

		tb_shift_enable = 1;
		@(posedge tb_HCLK);

		tb_shift_enable = 0;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);

		tb_data_out_1 = 8'h10;
		tb_data_out_2 = 8'h79;
		@(posedge tb_HCLK);

		tb_shift_enable = 1;
		@(posedge tb_HCLK);


		tb_shift_enable = 0;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);

		tb_data_out_1 = 8'h85;
		tb_data_out_2 = 8'h20;
		@(posedge tb_HCLK);

		tb_shift_enable = 1;
		@(posedge tb_HCLK);

		tb_shift_enable = 0;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_shift_enable = 1;
		@(posedge tb_HCLK);
		tb_shift_enable = 0;
		@(posedge tb_HCLK);

	end
endmodule