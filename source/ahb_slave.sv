// $Id: $
// File name:   ahb_slave.sv
// Created:     4/13/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: AHB Slave
module ahb_slave
(
	input wire HCLK, 
	input wire HRESETn, 
	input wire HREADY, 
	input wire HWRITE, 
	input wire [31:0] HWDATA, 
	input wire [31:0] HADDR,  
	output reg [2:0] status, 
	output reg [15:0] length, 
	output reg [15:0] width, 
	output reg [31:0] source_addr, 
	output reg [31:0] dest_addr, 
	output wire read_enable, 
	output wire write_enable
);
	wire decode_size_enable;
	wire decode_source_enable;
	wire decode_dest_enable;
	
	controller_ahb_slave AHB_SLAVE_CONTROLLER
	(
		.HCLK(HCLK), 
		.HRESETn(HRESETn), 
		.HREADY(HREADY), 
		.HWRITE(HWRITE), 
		.status(status), 
		.decode_size_enable(decode_size_enable), 
		.decode_source_enable(decode_source_enable), 
		.decode_dest_enable(decode_dest_enable), 
		.read_enable(read_enable), 
		.write_enable(write_enable)
	);

	decoder_ahb AHB_SLAVE_DECODER
	(
		.HCLK(HCLK), 
		.HRESETn(HRESETn), 
		.decode_size_enable(decode_size_enable), 
		.decode_source_enable(decode_source_enable), 
		.decode_dest_enable(decode_dest_enable), 
		.HWDATA(HWDATA), 
		.HADDR(HADDR), 
		.length(length), 
		.width(width), 
		.source_addr(source_addr), 
		.dest_addr(dest_addr)
	);
endmodule
