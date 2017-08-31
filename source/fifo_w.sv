// $Id: $
// File name:   fifo_w.sv
// Created:     3/22/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: FIFO (WRITE) for the AHB
module fifo_w
(
	input wire HCLK, 
	input wire HRESETn, 
	input wire shift_enable, 
	input wire [7:0] data_out_1, 
	input wire [7:0] data_out_2, 
	output reg [31:0] HWDATA
	//output wire transfer_data_complete_w
);
	reg [31:0] next_HWDATA;
	always_ff @ (posedge HCLK, negedge HRESETn)
	begin
		if (HRESETn == 0)
			HWDATA <= '1;
		else
			HWDATA <= next_HWDATA;
	end

	always_comb
	begin
		next_HWDATA = HWDATA;
		if (shift_enable) begin
			//next_HWDATA[24:8] = HWDATA[15:0];
			next_HWDATA[15:0] = (data_out_1 << 8) | data_out_2;
		end
		else
			next_HWDATA = HWDATA;
	end

	/*flex_counter2#(32) SHIFT_COUNTER_WRITE
	(
		.clk(HCLK), 
		.n_rst(HRESETn), 
		.count_enable(shift_enable), 
		.rollover_val(2), 
		.rollover_flag(transfer_data_complete_w)
	);*/
endmodule
