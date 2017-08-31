// $Id: $
// File name:   controller_ahb.sv
// Created:     3/21/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: AHB controller
module controller_ahb
(
	input wire HCLK, 
	input wire HRESETn, 
	input wire HREADY, 
	input wire read_enable, 
	input wire write_enable,  
	input wire transfer_addr_complete_r, 
	input wire transfer_data_complete_r, 
	//input wire shift_complete_r, 
	input wire transfer_addr_complete_w, 
	input wire transfer_data_complete_w,
	//input wire shift_complete_w, 
	input wire end_of_image, 
	output wire addr_enable_r, 
	output wire load_enable_r, 
	output wire shift_enable_r, 
	output wire addr_update_enable_r, 
	output wire addr_enable_w, 
	output wire shift_enable_w, 
	output wire addr_update_enable_w
);
	typedef enum bit [4:0] {IDLE, READY, READ_ADDR_1, WAIT_1, READ_DATA_1, SHIFT_1, READ_ADDR_2, WAIT_2, READ_DATA_2, SHIFT_2, READ_ADDR_3, WAIT_3, READ_DATA_3, SHIFT_3, ADDR_UPDATE_R, WRITE_ADDR, WAIT_W, WRITE_DATA, SHIFT_W, ADDR_UPDATE_W, READ_END, WRITE_END} stateType;
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
				next_state = READY;
			else
				next_state = IDLE;
		end

		READY: begin
			if (write_enable)
				next_state = WRITE_ADDR;
			else if (read_enable)
				next_state = READ_ADDR_1;
			else
				next_state = READY;
		end

		READ_ADDR_1: begin
			//if (transfer_addr_complete_r)
				next_state = READ_DATA_1;
			//else
			//	next_state = READ_ADDR_1;
		end

		/*WAIT_1: begin
			if (HREADY)
				next_state = READ_DATA_1;
			else
				next_state = WAIT_1;
		end*/

		READ_DATA_1: begin
			next_state = SHIFT_1;
		end

		SHIFT_1: begin
			if (transfer_data_complete_r)
				next_state = READ_ADDR_2;
			else
				next_state = SHIFT_1;
		end

		READ_ADDR_2: begin
			//if (transfer_addr_complete_r)
				next_state = READ_DATA_2;
			//else
			//	next_state = READ_ADDR_2;
		end

		/*WAIT_2: begin
			if (HREADY)
				next_state = READ_DATA_2;
			else
				next_state = WAIT_2;
		end*/

		READ_DATA_2: begin
			next_state = SHIFT_2;
		end

		SHIFT_2: begin
			if (transfer_data_complete_r)
				next_state = READ_ADDR_3;
			else
				next_state = SHIFT_2;
		end

		READ_ADDR_3: begin
			//if (transfer_addr_complete_r)
				next_state = READ_DATA_3;
			//else
			//	next_state = READ_ADDR_3;
		end

		/*WAIT_3: begin
			if (HREADY)
				next_state = READ_DATA_3;
			else
				next_state = WAIT_3;
		end*/

		READ_DATA_3: begin
			next_state = SHIFT_3;
		end

		SHIFT_3: begin
			if (end_of_image)
				next_state = READ_END;
			else if (transfer_data_complete_r)
				next_state = ADDR_UPDATE_R;
			else
				next_state = SHIFT_3;
		end

		ADDR_UPDATE_R: begin
			next_state = IDLE;
		end

		WRITE_ADDR: begin
			//if (transfer_addr_complete_w)
				next_state = WRITE_DATA;
			//else
			//	next_state = WRITE_ADDR;
		end

		/*WAIT_W: begin
			if (HREADY)
				next_state = WRITE_DATA;
			else
				next_state = WAIT_W;
		end*/

		/*WRITE_DATA: begin
			next_state = SHIFT_W;
		end*/

		WRITE_DATA: begin
			if (end_of_image)
				next_state = WRITE_END;
			else
			//if (transfer_data_complete_w)
				next_state = ADDR_UPDATE_W;
			//else
			//	next_state = SHIFT_W;
		end

		ADDR_UPDATE_W: begin
			next_state = IDLE;
		end

		READ_END: begin
			if (write_enable)
				next_state = WRITE_ADDR;
			else
				next_state = READ_END;
		end

		WRITE_END: begin
			next_state = WRITE_END;
		end

		endcase
	end


	assign addr_enable_r = (state == READ_ADDR_1) || (state == READ_ADDR_2) || (state == READ_ADDR_3);
	assign load_enable_r = (state == READ_DATA_1) || (state == READ_DATA_2) || (state == READ_DATA_3);
	assign shift_enable_r = (state == SHIFT_1) || (state == SHIFT_2) || (state == SHIFT_3);
	assign addr_update_enable_r = (state == ADDR_UPDATE_R);
	assign addr_enable_w = (state == WRITE_ADDR);
	assign shift_enable_w = (state == WRITE_DATA);
	assign addr_update_enable_w = (state == ADDR_UPDATE_W);
endmodule
