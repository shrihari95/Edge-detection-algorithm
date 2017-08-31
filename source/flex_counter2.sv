// $Id: $
// File name:   flex_counter2.sv
// Created:     1/26/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Flexible Counter
module flex_counter2
#(
	parameter NUM_CNT_BITS = 4
)
(
	input wire clk, 
	input wire n_rst, 
	input wire clear, 
	input wire count_enable, 
	input wire [NUM_CNT_BITS-1:0] rollover_val, 
	output reg [NUM_CNT_BITS-1:0] count_out, 
	output reg rollover_flag
);
	reg [NUM_CNT_BITS-1:0] nxt_count;
	reg rollover_det;
	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == 0)
			count_out <= 0;
		else
			count_out <= nxt_count;
	end

	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == 0)
			rollover_flag <= 0;
		else
			rollover_flag <= rollover_det;
	end

	always_comb
	begin
		rollover_det = rollover_flag;
		if (clear == 1)
		begin
			nxt_count = 0;
			rollover_det = 0;
		end
		else if (count_enable == 0)
		begin
			nxt_count = count_out;
			//rollover_det = 0;
		end
		else
		begin
			nxt_count = count_out + 1;

			if ((count_out == rollover_val - 1))// && (count_enable == 1) && (clear == 0))
				rollover_det = 1;
			else
				rollover_det = 0;

			if ((count_out == rollover_val))// && (count_enable == 1) && (clear == 0))
				nxt_count = 1;
		end

	end
endmodule
