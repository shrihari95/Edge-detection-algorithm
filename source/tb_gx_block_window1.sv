// $Id: $
// File name:   tb_gx_block_window1.sv
// Created:     4/5/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for gx -1

`timescale 1ns / 100ps
module tb_gx_block_window1 ();

    // Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay

    reg tb_clk;
    reg tb_n_rst;
    reg unsigned [11:0][7:0]tb_data_buffer ;
    /*assign tb_data_buffer[0] = 10;
    assign tb_data_buffer[1] = 10;
    assign tb_data_buffer[2] = 10;
    assign tb_data_buffer[3] = 10;
    assign tb_data_buffer[4] = 10;
    assign tb_data_buffer[5] = 10;
    assign tb_data_buffer[6] = 20;
    assign tb_data_buffer[7] = 20;
    assign tb_data_buffer[8] = 20;
    assign tb_data_buffer[9] = 20;
    assign tb_data_buffer[10] = 20;
    assign tb_data_buffer[11] = 20;*/
    
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
    reg [10:0]tb_gx_out_1;
    gx_block_window1 gx1
    (   .clk(tb_clk), 
	.n_rst(tb_n_rst), 
	.data_buffer(tb_data_buffer),
        .enable_calc(tb_enable_calc),
        .gx_out_1(tb_gx_out_1)
    );
	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end
	
    initial
    begin
	tb_n_rst = 1;
	tb_enable_calc = 1'b0;
	@(posedge tb_clk);
	tb_n_rst = 0;
	@(posedge tb_clk);
	tb_n_rst = 1;
	@(posedge tb_clk);
    	#(CHECK_DELAY);
    	
    	
    	tb_enable_calc = 1'b1;
	@(posedge tb_clk);
	 
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	
	
	//assert(tb_gx_out_1==200)
	//  $info("CASE 1: PASSED");
	//else
	//  $error("CASE 1: FAILED");
	
	#(CHECK_DELAY);
    	
    
	
    end
endmodule

    	
