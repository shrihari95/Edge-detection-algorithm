// $Id: $
// File name:   pipelining_test.sv
// Created:     3/31/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Testing the pipelining
module pipelining_test
(
	input wire clk, 
	input wire n_rst, 
	input wire increment_enable, 
	input wire multiply_enable, 
	input wire [3:0] a, 
	input wire [3:0] b, 
	output reg [8:0] e
);
	reg [3:0] next_c;
	reg [3:0] c;
	reg [3:0] next_d;
	reg [3:0] d;
	reg [8:0] next_e;


	typedef enum bit [2:0] {IDLE, INCREMENT, MULTIPLY} stateType;
	stateType state, next_state;

	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == 0) begin
			c <= 0;
			d <= 0;
			e <= 0;
			state <= IDLE;
		end
		else begin
			c <= next_c;
			d <= next_d;
			e <= next_e;
			state <= next_state;
		end
	end

	always_comb
	begin
		next_state = state;
		case(state)
		IDLE: begin
			if (increment_enable)
				next_state = INCREMENT;
		end
		INCREMENT: begin
			if (multiply_enable)
				next_state = MULTIPLY;
		end
		MULTIPLY: begin
			next_state = INCREMENT;
		end
		endcase
	end

	always_comb
	begin
		next_c = a;
		next_d = b;
		if (state == INCREMENT) begin
			next_c = a + 3;
			next_d = b + 3;
		end

		if (state == MULTIPLY) begin
			next_e = c * d;
		end
	end
endmodule
