// $Id: $
// File name:   mcu.sv
// Created:     3/15/2017
// Author:      Shrihari Sridharan
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Main control unit - This controls the overall flow of the edge detection by allowing to wait for particular clock cycles before performing any action


module mcu(
input wire clk,
input wire n_rst,
input wire shift_enable_r,
input wire transfer_data_complete_r,
input wire transfer_data_complete_w,
output reg enable_calc, 
output wire buffer_clear
);

typedef enum bit [5:0] {idle, read1, read2, read3, CALCULATE, WAIT, write, CLEAR} states;//gx1, wait1, gx2, wait2, gy1, wait3, gy2, wait4, result1, result2, write, CLEAR} states;
states state;
states next_state;

always_ff @(posedge clk,negedge n_rst)
begin
	if (n_rst == 0)
		state <= idle;
	else
		state <= next_state;
end


always_comb
begin 
next_state = state; 
	case (state)
	idle: begin
		if(shift_enable_r==1'b1)
			next_state = read1;
		else
			next_state = idle;
		end
	read1: begin
		if(transfer_data_complete_r==1'b1)
			next_state = read2;
		else
			next_state = read1;
		end
	read2: begin
		if(transfer_data_complete_r==1'b1)
			next_state = read3;
		else
			next_state = read2;
		end
	read3: begin
		if(transfer_data_complete_r==1'b1)
			next_state = CALCULATE;
		else
			next_state = read3;
		end
	CALCULATE: begin
		next_state = WAIT;
	end

	WAIT: begin
		next_state = write;
	end
	/*gx1: begin
		next_state = wait1;
		end
	wait1: begin
		next_state= gx2;
		end
	gx2: begin
		next_state = wait2;
		end
	wait2: begin
		next_state= gy1;
		end
	gy1: begin
		next_state = wait3;
		end
	wait3: begin
		next_state= gy2;
		end	
	gy2: begin
		next_state = wait4;
		end
	wait4: begin
		next_state= result1;
		end
	result1: begin
		next_state= result2;
		end
	result2: begin
		next_state= write;
		end*/
	write: begin
		//if(transfer_data_complete_w == 1'b1)
			next_state= CLEAR;
		//else
		//	next_state = write;
		end
	CLEAR: begin
		next_state = idle;
	end
	default: begin
		   next_state = idle;
	         end
	endcase
end


assign buffer_clear = (state == CLEAR);

always_comb
begin
	
	enable_calc = 1'b0;
	if (state == CALCULATE)
		enable_calc = 1'b1;
	/*if(state == gx1 || state == gy1|| state == gx2|| state == gy2) begin
		enable_calc = 1'b1;
	end*/	
	
end
endmodule


/*module mcu(
input wire clk,
input wire n_rst,
input wire buffer_empty, 
input wire complete,
input wire buffer_full,
input wire gx_done,
input wire gy_done,
output reg read_enable,
output reg enable_calc,
output reg write_enable
);

typedef enum bit [5:0] {idle, pixel_1,pixel_2,pixel_3,pixel_4,pixel_5,pixel_6,pixel_7,pixel_8,pixel_9,pixel_10,pixel_11,pixel_12,gx_calc,gy_calc,mag_calc,compare,write,buffer_clear} states;
states state;
states next_state;

always_ff @(posedge clk,negedge n_rst)
begin
	if (n_rst == 0)
		state <= idle;
	else
		state <= next_state;
end


always_comb
begin 
next_state = state; 
	case (state)
	idle: begin
		if(buffer_empty==1'b0)
			next_state = pixel_1;
		else
			next_state = idle;
		end
	pixel_1: begin
		 if(complete == 1'b1 && buffer_full == 1'b0) 
		 	next_state = pixel_2;
		 else if(complete == 1'b0)
		 	next_state = pixel_1;
		 end
	pixel_2: begin
		 if(complete == 1'b1 && buffer_full == 1'b0) 
		 	next_state = pixel_3;
		 else if(complete == 1'b0)
		 	next_state = pixel_2;
		 end
	pixel_3: begin
		 if(complete == 1'b1 && buffer_full == 1'b0) 
		 	next_state = pixel_4;
		 else if(complete == 1'b0)
		 	next_state = pixel_3;
		 end
	pixel_4: begin
		 if(complete == 1'b1 && buffer_full == 1'b0) 
		 	next_state = pixel_5;
		 else if(complete == 1'b0)
		 	next_state = pixel_4;
		 end
	pixel_5: begin
		 if(complete == 1'b1 && buffer_full == 1'b0) 
		 	next_state = pixel_6;
		 else if(complete == 1'b0)
		 	next_state = pixel_5;
		 end
	pixel_6: begin
		 if(complete == 1'b1 && buffer_full == 1'b0) 
		 	next_state = pixel_7;
		 else if(complete == 1'b0)
		 	next_state = pixel_6;
		 end
	pixel_7: begin
		 if(complete == 1'b1 && buffer_full == 1'b0) 
		 	next_state = pixel_8;
		 else if(complete == 1'b0)
		 	next_state = pixel_7;
		 end
	pixel_8: begin
		 if(complete == 1'b1 && buffer_full == 1'b0) 
		 	next_state = pixel_9;
		 else if(complete == 1'b0)
		 	next_state = pixel_8;
		 end
	pixel_9: begin
		 if(complete == 1'b1 && buffer_full == 1'b0) 
		 	next_state = pixel_10;
		 else if(complete == 1'b0)
		 	next_state = pixel_9;
		 end
	pixel_10: begin
		 if(complete == 1'b1 && buffer_full == 1'b0) 
		 	next_state = pixel_11;
		 else if(complete == 1'b0)
		 	next_state = pixel_10;
		 end
	pixel_11: begin
		 if(complete == 1'b1 && buffer_full == 1'b0) 
		 	next_state = pixel_12;
		 else if(complete == 1'b0)
		 	next_state = pixel_11;
		 end
	pixel_12: begin
		  if(complete == 1'b1 && buffer_full == 1'b1) 
		 	next_state = gx_calc;
		 else if(complete == 1'b0)
		 	next_state = pixel_12;
		 end
	gx_calc: begin
		 if(gx_done == 1'b1) 
		 	next_state = gy_calc;
		 else 
		 	next_state =gx_calc;
		 end
	gy_calc: begin
		  if(gy_done == 1'b1)
		  	next_state = mag_calc;
		  else
		  	next_state = gy_calc;
		  end
	mag_calc:begin
		    next_state = compare;
		  end
	compare: begin
		   next_state = write;
		  end
	write: begin
		   next_state = buffer_clear;
		 end
	buffer_clear: begin
			if(buffer_empty == 1'b1)
			  next_state = idle;
			else
			  next_state = buffer_clear;
		      end
	default: begin
		   next_state = idle;
	         end
	endcase
end


always_comb
begin
	
	read_enable = 1'b0;
	enable_calc = 1'b0;
	write_enable = 1'b0;
	if(state == idle) begin
		read_enable = 1'b1;
	end
	if(state == gx_calc || state == gy_calc) begin
		enable_calc = 1'b1;
	end
	if(state == write) begin
		write_enable = 1'b1;
	end
end
endmodule
*/
