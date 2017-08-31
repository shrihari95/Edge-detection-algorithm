// $Id: $
// File name:   fifo_r.sv
// Created:     3/22/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: FIFO (READ) of AHB
module fifo_r
(
	input wire HCLK, 
	input wire HRESETn, 
	input wire shift_enable, 
	input wire load_enable, 
	input wire [31:0] HRDATA, 
	output byte data_in, 
	output wire transfer_data_complete_r
);
	reg [31:0] next_read_data;
	reg [31:0] array_out;

	always_ff @ (posedge HCLK, negedge HRESETn)
	begin
		if (HRESETn == 0)
			array_out <= '1;
		else
			array_out <= next_read_data;
	end

	always_comb
	begin
		next_read_data = array_out;
		data_in = array_out[31:24];
		if (load_enable)
			next_read_data = HRDATA;
		else if (shift_enable) begin
			next_read_data[31:8] = array_out[23:0];
			next_read_data[7:0] = '1;
			//data_in = array_out[31:24];
		end
		else begin
			next_read_data = array_out;
		end
	end
	//assign data_in = array_out[31:24];

	flex_counter#(32) SHIFT_COUNTER_READ
	(
		.clk(HCLK), 
		.n_rst(HRESETn), 
		.count_enable(shift_enable), 
		.rollover_val(3), 
		.rollover_flag(transfer_data_complete_r)
	);
endmodule