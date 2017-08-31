// $Id: $
// File name:   abh_master.sv
// Created:     3/21/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: AHB BLOCK
module ahb_master
(
	input wire HCLK, 
	input wire HRESETn, 
	input wire HREADY, 
	input wire read_enable, 
	input wire write_enable,  
	input reg [15:0] length, 
	input reg [15:0] width, 
	input reg [31:0] source_addr, 
	input reg [31:0] dest_addr, 
	input wire [31:0] HRDATA, 
	input wire [7:0] sobel_result1, 
	input wire [7:0] sobel_result2, 
	output reg [31:0] HADDR, 
	output wire [7:0] pixel_out, 
	output reg [31:0] HWDATA, 
	output reg HWRITE, 
	output wire transfer_data_complete_r, 
	output wire transfer_data_complete_w, 
	output wire shift_enable_r
);
	wire transfer_addr_complete_r;
	//wire shift_complete_r;
	wire transfer_addr_complete_w;
	wire end_of_image;
	//wire shift_complete_w;
	wire addr_enable_r;
	wire load_enable_r;
	wire addr_update_enable_r;
	wire addr_enable_w;
	wire shift_enable_w;
	wire addr_update_enable_w;

	reg plus4_r;

	//reg [15:0] read_data;
	reg [31:0] start_addr;
	reg [31:0] curr_addr_r;
	reg [31:0] curr_addr_w;


	controller_ahb AHB_CONTROLLER
	(
		.HCLK(HCLK), 
		.HRESETn(HRESETn), 
		.HREADY(HREADY), 
		.read_enable(read_enable), 
		.write_enable(write_enable), 
		.transfer_addr_complete_r(transfer_addr_complete_r), 
		.transfer_data_complete_r(transfer_data_complete_r), 
		.transfer_addr_complete_w(transfer_addr_complete_w), 
		.transfer_data_complete_w(transfer_data_complete_w), 
		.end_of_image(end_of_image), 
		.addr_enable_r(addr_enable_r), 
		.load_enable_r(load_enable_r), 
		.shift_enable_r(shift_enable_r), 
		.addr_update_enable_r(addr_update_enable_r), 
		.addr_enable_w(addr_enable_w), 
		.shift_enable_w(shift_enable_w), 
		.addr_update_enable_w(addr_update_enable_w)
	);

	always_comb
	begin
		if (read_enable) begin
			HADDR = start_addr;
			HWRITE = 0;
		end
		else if (write_enable) begin
			HADDR = curr_addr_w;
			HWRITE = 1;
		end
		else begin
			HADDR = 'z;
			HWRITE = 'z;
		end
	end

	//always
	//begin
		//if (status == 2'b11) begin
			address_update_w ADDRESS_UPDATE_WRITE
			(
				.HCLK(HCLK), 
				.HRESETn(HRESETn),  
				.length(length), 
				.width(width), 
				.addr(dest_addr), 
				.addr_update_enable_w(addr_update_enable_w), 
				.plus4_r(plus4_r), 
				.curr_addr(curr_addr_w)
			);

			fifo_w WRITE_PIXEL_DATA
			(
				.HCLK(HCLK), 
				.HRESETn(HRESETn), 
				.shift_enable(shift_enable_w), 
				.data_out_1(sobel_result1), 
				.data_out_2(sobel_result2), 
				.HWDATA(HWDATA)
				//.transfer_data_complete_w(transfer_data_complete_w)
			);
		//end
		//else if (status == 2'b10) begin
			address_update_r ADDRESS_UPDATE_READ
			(
				.HCLK(HCLK), 
				.HRESETn(HRESETn), 
				.length(length), 
				.width(width), 
				.addr(source_addr), 
				.addr_update_enable_r(addr_update_enable_r), 
				.curr_addr(curr_addr_r), 
				.plus4_r(plus4_r),  
				.end_of_image(end_of_image)
			);

			get_address_r GET_STARTING_ADDRESS_READ
			(
				.HCLK(HCLK), 
				.HRESETn(HRESETn),
				.addr_enable_r(addr_enable_r), 
				.curr_addr(curr_addr_r), 
				.length(length), 
				.width(width), 
				.start_addr_r(start_addr), 
				.transfer_addr_complete_r(transfer_addr_complete_r)
			);

			fifo_r SEND_PIXEL_DATA
			(
				.HCLK(HCLK), 
				.HRESETn(HRESETn), 
				.shift_enable(shift_enable_r), 
				.load_enable(load_enable_r), 
				.HRDATA(HRDATA), 
				.data_in(pixel_out), 
				.transfer_data_complete_r(transfer_data_complete_r)
			);
		//end

	//end


endmodule
