// $Id: $
// File name:   tb_mcu.sv
// Created:     4/8/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for the main controller

`timescale 1ns / 100ps
module tb_mcu();
  // Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay

    reg tb_clk;
    reg tb_n_rst;
    reg tb_load_enable_r;
    reg tb_transfer_data_complete_r;
    reg tb_transfer_data_complete_w;
    reg tb_enable_calc;
    reg tb_buffer_clear;
    
    
    mcu main(
   .clk(tb_clk),
   .n_rst(tb_n_rst),
   .load_enable_r(tb_load_enable_r),
   .transfer_data_complete_r(tb_transfer_data_complete_r),
   .transfer_data_complete_w(tb_transfer_data_complete_w),
   .enable_calc(tb_enable_calc), 
   .buffer_clear(tb_buffer_clear)
   );
   
	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
    initial
    begin
	tb_n_rst = 1'b0;
    	#(CHECK_DELAY);
    	tb_n_rst = 1'b1;
    	@(posedge tb_clk);
    	#(CHECK_DELAY);
    	tb_load_enable_r = 1'b1;
    	@(posedge tb_clk);
    	#(CHECK_DELAY);
    	#(CHECK_DELAY);
    	#(CHECK_DELAY);
    	tb_transfer_data_complete_r = 1'b1;
    	@(posedge tb_clk);
    	#(CHECK_DELAY);
    	#(CHECK_DELAY);
    	#(CHECK_DELAY);
	tb_transfer_data_complete_w = 1'b1;
	if(tb_read_enable_1 == 1'b1)
	  $info("CASE 1: PASSED");
	else
	  $error("CASE 1: FAILED");
	  
	  
    end
endmodule
