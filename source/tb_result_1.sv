// $Id: $
// File name:   tb_result_1.sv
// Created:     4/8/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for result 1

`timescale 1ns / 100ps
module tb_result_1 ();

    // Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay
	reg [10:0]tb_gx_out_1;
	reg [10:0]tb_gy_out_1;
	byte tb_final_out_1;
	

	
	result_1 r1
        (.gx_out_1(tb_gx_out_1),
         .gy_out_1(tb_gy_out_1),
         .final_out_1(tb_final_out_1)
    	);
	// Clock generation block
	
    initial
    begin
	tb_gx_out_1 = 200;
	tb_gy_out_1 = 112; 
    	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	assert(tb_final_out_1 == 255)
	  $info("CASE 1: PASSED");
	else
	  $error("CASE 1: FAILED");
	
	#(CHECK_DELAY);

	tb_gx_out_1 = -262;
	tb_gy_out_1 = 136;
    	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	
   end
endmodule
