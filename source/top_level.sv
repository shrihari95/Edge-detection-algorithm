// $Id: $
// File name:   top_level.sv
// Created:     4/18/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Top level of the whole edge detection module
module top_level
(
	input wire clk, 
	input wire n_rst, 
	input wire HWRITE_S, 
	input wire HREADY_M, 
	input wire HREADY_S, 
	input wire [31:0] HADDR_S, 
	input wire [31:0] HRDATA_M, 
	input wire [31:0] HWDATA_S, 
	output wire HWRITE_M, 
	output reg [31:0] HADDR_M, 
	output reg [31:0] HWDATA_M
);
	reg [2:0] status;
	reg [15:0] length;
	reg [15:0] width;
	reg [31:0] source_addr;
	reg [31:0] dest_addr;

	wire read_enable;
	wire write_enable;

	reg [7:0] final_out_1;
	reg [7:0] final_out_2;
	reg [7:0] pixel_out;
	wire transfer_data_complete_r;
	wire transfer_data_complete_w;
	wire shift_enable_r;

	reg unsigned [11:0][7:0] data_buffer;
	wire buffer_clear;
	wire buffer_full;
	wire buffer_empty;


	ahb_slave AHB_SLAVE_PROTOCOL
	(
		.HCLK(clk), 
		.HRESETn(n_rst), 
		.HREADY(HREADY_S), 
		.HWRITE(HWRITE_S), 
		.HWDATA(HWDATA_S), 
		.HADDR(HADDR_S), 
		.status(status), 
		.length(length), 
		.width(width), 
		.source_addr(source_addr), 
		.dest_addr(dest_addr), 
		.read_enable(read_enable), 
		.write_enable(write_enable)
	);

	ahb_master AHB_MASTER_PROTOCOL
	(
		.HCLK(clk), 
		.HRESETn(n_rst), 
		.HREADY(HREADY_M), 
		.read_enable(read_enable), 
		.write_enable(write_enable),  
		.length(length), 
		.width(width), 
		.source_addr(source_addr), 
		.dest_addr(dest_addr), 
		.HRDATA(HRDATA_M), 
		.sobel_result1(final_out_1), 
		.sobel_result2(final_out_2), 
		.HADDR(HADDR_M), 
		.pixel_out(pixel_out), 
		.HWDATA(HWDATA_M), 
		.HWRITE(HWRITE_M), 
		.transfer_data_complete_r(transfer_data_complete_r), 
		.transfer_data_complete_w(transfer_data_complete_w), 
		.shift_enable_r(shift_enable_r)
	);

	fill_in_buffer DATA_BUFFER
	(
		.clk(clk), 
		.n_rst(n_rst), 
		.shift_enable(shift_enable_r), 
		.buffer_clear(buffer_clear), 
		.read_data(pixel_out), 
		.data_buffer(data_buffer), 
		.buffer_full(buffer_full), 
		.buffer_empty(buffer_empty)
	);

	overall_edge_det EDGE_DETECTION_MODULE
	(
		.clk(clk), 
		.n_rst(n_rst), 
		.data_buffer(data_buffer), 
		.shift_enable_r(shift_enable_r), 
		.transfer_data_complete_r(transfer_data_complete_r), 
		.transfer_data_complete_w(transfer_data_complete_w), 
		.final_out_1(final_out_1), 
		.final_out_2(final_out_2), 
		.buffer_clear(buffer_clear)
	);
endmodule
