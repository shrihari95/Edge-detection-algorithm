// $Id: $
// File name:   tb_overall_edge_det.sv
// Created:     4/13/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Overall test bench for edge detection module


`timescale 1ns/10ps


module tb_overall_edge_det();
	localparam	CLK_PERIOD	= 10;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay


reg unsigned [11:0][7:0] tb_data_buffer;
    
     /* assign tb_data_buffer[0] = 0;
    assign tb_data_buffer[1] = 0;
    assign tb_data_buffer[2] = 0;
    assign tb_data_buffer[3] = 0;
    assign tb_data_buffer[4] = 0;
    assign tb_data_buffer[5] = 0;
    assign tb_data_buffer[6] = 0;
    assign tb_data_buffer[7] = 0;
    assign tb_data_buffer[8] = 0;
    assign tb_data_buffer[9] = 0;
    assign tb_data_buffer[10] = 0;
    assign tb_data_buffer[11] = 0;*/



    reg tb_clk;
    reg tb_n_rst;
    reg tb_shift_enable_r;
    reg tb_transfer_data_complete_r;
    reg tb_transfer_data_complete_w;
    byte tb_final_out_1;
    byte tb_final_out_2;   
    reg tb_buffer_clear;
  
	
	
overall_edge_det overall
(
	.clk(tb_clk),
	.n_rst(tb_n_rst),
	.data_buffer(tb_data_buffer),
	.shift_enable_r(tb_shift_enable_r),
        .transfer_data_complete_r(tb_transfer_data_complete_r),
        .transfer_data_complete_w(tb_transfer_data_complete_w),
	.final_out_1(tb_final_out_1),
	.final_out_2(tb_final_out_2), 
	.buffer_clear(tb_buffer_clear)
);

  
    // Clock gen block
	always
	begin : CLK_GEN
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2.0);
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2.0);
	end


    initial
    begin
    	 tb_shift_enable_r = 1'b0;
    tb_transfer_data_complete_r = 1'b0;
    tb_transfer_data_complete_w = 1'b0;
	tb_data_buffer[0] = 100;
	tb_data_buffer[1] = 100;
	tb_data_buffer[2] = 100;
	tb_data_buffer[3] = 100;
	tb_data_buffer[4] = 100;
	tb_data_buffer[5] = 100;
	tb_data_buffer[6] = 200;
	tb_data_buffer[7] = 200;
	tb_data_buffer[8] = 200;
	tb_data_buffer[9] = 200;
	tb_data_buffer[10] = 200;
	tb_data_buffer[11] = 200;    
	tb_n_rst = 1'b0;
    	#(CHECK_DELAY);
    	tb_n_rst = 1'b1;
    	@(posedge tb_clk);
    	
	 @(posedge tb_clk);
	 tb_shift_enable_r = 1;
	@(posedge tb_clk);
	tb_shift_enable_r = 0;
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 1;
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 0;
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 1;
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 0;
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 1;
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 0;
	@(posedge tb_clk);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	 @(posedge tb_clk); // GX1
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	tb_transfer_data_complete_w = 1;
	@(posedge tb_clk); // CLEAR
	@(posedge tb_clk);

	tb_data_buffer[0] = 135;
	tb_data_buffer[1] = 56;
	tb_data_buffer[2] = 48;
	tb_data_buffer[3] = 100;
	tb_data_buffer[4] = 50;
	tb_data_buffer[5] = 49;
	tb_data_buffer[6] = 10;
	tb_data_buffer[7] = 80;
	tb_data_buffer[8] = 165;
	tb_data_buffer[9] = 98;
	tb_data_buffer[10] = 70;
	tb_data_buffer[11] = 150;
   
	 tb_shift_enable_r = 1;
	@(posedge tb_clk);
	tb_shift_enable_r = 0;
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 1;
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 0;
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 1;
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 0;
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 1;
	@(posedge tb_clk);
	tb_transfer_data_complete_r = 0;
	@(posedge tb_clk);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	 @(posedge tb_clk); // GX1
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	#(CHECK_DELAY);
	tb_transfer_data_complete_w = 1;
	@(posedge tb_clk); // CLEAR
	@(posedge tb_clk);
    end
endmodule
