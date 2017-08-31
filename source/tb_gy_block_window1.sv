// $Id: $
// File name:   tb_gy_block_window1.sv
// Created:     4/6/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for gy block 1

`timescale 1ns / 100ps
module tb_gy_block_window1 ();

    // Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay

    reg tb_clk;
    reg tb_n_rst;
    reg unsigned [11:0][7:0]tb_data_buffer ;
    
    assign tb_data_buffer[0] = 100;
    assign tb_data_buffer[1] = 100;
    assign tb_data_buffer[2] = 100;
    assign tb_data_buffer[3] = 100;
    assign tb_data_buffer[4] = 100;
    assign tb_data_buffer[5] = 100;
    assign tb_data_buffer[6] = 200;
    assign tb_data_buffer[7] = 200;
    assign tb_data_buffer[8] = 200;
    assign tb_data_buffer[9] = 200;
    assign tb_data_buffer[10] = 200;
    assign tb_data_buffer[11] = 200;
    
    reg tb_enable_calc;
    reg [10:0]tb_gy_out_1;
    gy_block_window1 gy1
    (   .clk(tb_clk), 
	.n_rst(tb_n_rst), 
    	.data_buffer(tb_data_buffer),
        .enable_calc(tb_enable_calc),
        .gy_out_1(tb_gy_out_1)
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
	tb_enable_calc = 1'b0;
	tb_n_rst = 1'b1;
	@(posedge tb_clk);
	tb_n_rst = 1'b0;
	@(posedge tb_clk);
    	#(CHECK_DELAY);
    	tb_n_rst = 1'b1;
    	@(posedge tb_clk);
    	tb_enable_calc = 1'b1;
	 //@(posedge tb_clk);
	 
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);	
	if(tb_gy_out_1== 400)
	  $info("CASE 1: PASSED");
	else
	  $error("CASE 1: FAILED");
	//tb_n_rst = 1'b1;
	// @(posedge tb_clk);
	
	#(CHECK_DELAY);
    	
    
	
    end
endmodule
