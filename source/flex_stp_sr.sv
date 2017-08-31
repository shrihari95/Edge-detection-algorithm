// $Id: $
// File name:   flex_stp_sr.sv
// Created:     1/26/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: serial-to-parallel shift register
module flex_stp_sr
#(
	parameter NUM_BITS = 4, 
	parameter SHIFT_MSB = 1
)
(
	input wire clk, 
	input wire n_rst, 
	input wire shift_enable, 
	input wire serial_in, 
	output reg [NUM_BITS-1:0] parallel_out
);
	reg [NUM_BITS-1:0] data_in;
	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == 0)
			parallel_out[NUM_BITS-1:0] <= '1;
		else
			parallel_out[NUM_BITS-1:0] <= data_in;
	end

	always_comb
	begin
		if (shift_enable == 1'b0)
			data_in = parallel_out;
		else
		begin
			if (SHIFT_MSB == 1)
			begin
				data_in[NUM_BITS-1:1] = parallel_out[NUM_BITS-2:0];
				data_in[0] = serial_in;
			end
			else
			begin
				data_in[NUM_BITS-1] = serial_in;
				data_in[NUM_BITS-2:0] = parallel_out[NUM_BITS-1:1];
			end
		end
	end
endmodule
