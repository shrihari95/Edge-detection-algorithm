// $Id: $
// File name:   controller_ahb_slave.sv
// Created:     4/13/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: AHB Slave Controller
module controller_ahb_slave
(
	input wire HCLK, 
	input wire HRESETn, 
	input wire HREADY, 
	input wire HWRITE, 
	output reg [2:0] status, 
	output wire decode_size_enable, 
	output wire decode_source_enable, 
	output wire decode_dest_enable, 
	output wire read_enable, 
	output wire write_enable
);
	typedef enum bit [2:0] {IDLE, SIZE_DECODE, SOURCE_ADDR_DECODE, DEST_ADDR_DECODE, READ, WRITE} stateType;
	stateType state, next_state;

	always_ff @ (posedge HCLK, negedge HRESETn)
	begin
		if (HRESETn == 0)
			state <= IDLE;
		else
			state <= next_state;
	end

	always_comb
	begin
		next_state = state;
		case(state)
		IDLE: begin
			if (HREADY)
				next_state = SIZE_DECODE;
			else
				next_state = IDLE;
		end

		SIZE_DECODE: begin
			if (HREADY)
				next_state = SOURCE_ADDR_DECODE;
			else
				next_state = IDLE;
		end

		SOURCE_ADDR_DECODE: begin
			if (!HREADY)
				next_state = IDLE;
			else
				next_state = DEST_ADDR_DECODE;
		end

		DEST_ADDR_DECODE: begin
			if (!HREADY)
				next_state = IDLE;
			else if (!HWRITE)
				next_state = READ;
			else
				next_state = WRITE;
		end
		READ: begin
			if (HWRITE)
				next_state = WRITE;
			else
				next_state = READ;
		end
		WRITE: begin
			if (!HWRITE)
				next_state = READ;
			else
				next_state = WRITE;
		end
		endcase
	end

	always_comb
	begin
		status = 3'b000;
		case(state)
		IDLE: status = 3'b000;
		SIZE_DECODE: status = 3'b001;
		SOURCE_ADDR_DECODE: status = 3'b010;
		DEST_ADDR_DECODE: status = 3'b011;
		READ: status = 3'b100;
		WRITE: status = 3'b101;
		endcase
	end
	assign decode_size_enable = (state == SIZE_DECODE);
	assign decode_source_enable = (state == SOURCE_ADDR_DECODE);
	assign decode_dest_enable = (state == DEST_ADDR_DECODE);
	assign read_enable = (state == READ);
	assign write_enable = (state == WRITE);
endmodule
