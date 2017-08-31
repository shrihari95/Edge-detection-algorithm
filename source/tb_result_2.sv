// $Id: $
// File name:   tb_result_2.sv
// Created:     4/8/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for result 2

`timescale 1ns / 100ps
module tb_result_2 ();

    // Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay
	reg [10:0] tb_gx_out_2;
	reg [10:0] tb_gy_out_2;
	byte tb_final_out_2;
	

	
	result_2 r2
        (.gx_out_2(tb_gx_out_2),
         .gy_out_2(tb_gy_out_2),
         .final_out_2(tb_final_out_2)
    	);
	// Clock generation block
	
    initial
    begin
	tb_gx_out_2 = 100;
	tb_gy_out_2 = 100; 
    	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	assert(tb_final_out_2 == 255)
	  $info("CASE 1: PASSED");
	else
	  $error("CASE 1: FAILED");
	
	#(CHECK_DELAY);
	tb_gx_out_2 = -40;
	tb_gy_out_2 = 100; 
    	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
   end
endmodule
