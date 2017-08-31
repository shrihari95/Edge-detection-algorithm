// $Id: $
// File name:   flex_pts_sr.sv
// Created:     1/26/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: parallel-to-serial shift register
module flex_pts_sr
#(
	parameter NUM_BITS = 4, 
	parameter SHIFT_MSB = 1
)
(
	input wire clk, 
	input wire n_rst, 
	input wire shift_enable, 
	input wire load_enable, 
	input wire [NUM_BITS-1:0] parallel_in, 
	output wire serial_out
);
	reg [NUM_BITS-1:0] next_data;
	reg [NUM_BITS-1:0] data_out;
	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == 1'b0)
			data_out <= '1;
		else
			data_out <= next_data;
	end

	always_comb
	begin
		if (load_enable == 1)
			next_data = parallel_in;
		else
		begin
			if (shift_enable == 1)
			begin
				if (SHIFT_MSB == 1)
				begin
					next_data[NUM_BITS-1:1] = data_out[NUM_BITS-2:0];
					next_data[0] = 1;
					
				end
				else
				begin
					next_data[NUM_BITS-1] = 1;
					next_data[NUM_BITS-2:0] = data_out[NUM_BITS-1:1];
					
				end
			end
			else
				next_data = data_out;
		end
	end
	assign serial_out = SHIFT_MSB & data_out[NUM_BITS-1] || !SHIFT_MSB & data_out[0];
endmodule
