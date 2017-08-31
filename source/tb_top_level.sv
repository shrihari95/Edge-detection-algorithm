// $Id: $
// File name:   tb_top_level.sv
// Created:     4/18/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench for the top level
`timescale 1ns / 10ps

module tb_top_level();
	
	localparam CLK_PERIOD = 40;

	parameter INPUT_FILE_NAME = "./docs/test_1.bmp";
	parameter OUTPUT_FILE_NAME = "./docs/result_t.bmp";

	// Bitmap based parameters
	localparam BMP_HEADER_SIZE	= 14; // BMP file header is 14 bytes
	localparam PIXEL_ARR_PTR_ADDR	= BMP_HEADER_SIZE - 4;
	localparam DIB_HEADER_C1_SIZE	= 40; // The length of expected BITMAPINFOHEADER DIB header
	localparam DIB_HEADER_C2_SIZE	= 12; // The length of expected BITMAPCOREHEADER DIB header
	localparam IMAGE_WIDTH	= 400; // Image width
	localparam IMAGE_HEIGHT = 400; // Image height
	localparam SOURCE_ADDR = 0;
	localparam DEST_ADDR = 200000;

	// DUT signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_HWRITE_M;
	reg tb_HWRITE_S;
	reg tb_HREADY_M;
	reg tb_HREADY_S;
	reg [31:0] tb_HADDR_M;
	reg [31:0] tb_HADDR_S;
	reg [31:0] tb_HRDATA_M;
	reg [31:0] tb_HWDATA_M;
	reg [31:0] tb_HWDATA_S;

	top_level DUT_TOP_LEVEL
	(
		.clk(tb_clk), 
		.n_rst(tb_n_rst), 
		.HWRITE_S(tb_HWRITE_S), 
		.HREADY_M(tb_HREADY_M), 
		.HREADY_S(tb_HREADY_S), 
		.HADDR_S(tb_HADDR_S), 
		.HRDATA_M(tb_HRDATA_M), 
		.HWDATA_S(tb_HWDATA_S), 
		.HWRITE_M(tb_HWRITE_M), 
		.HADDR_M(tb_HADDR_M), 
		.HWDATA_M(tb_HWDATA_M)
	);

	// Generate Clock
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end

	// Image Processing Test Bench variables
	integer in_file;	// Input file pointer
	integer out_file;	// Output file pointer
	reg [31:0] DIB_header_size; // DIB Header Size
	integer row; // Number of pixel rows
	integer column; // Number of pixel columns
	integer i, j; // Index
	integer quiet_catch; // Prevent warnings for not capturing the value of the file function returns
	integer start_addr;

	reg [9:0] image_array [(6*(IMAGE_WIDTH)*(IMAGE_HEIGHT)-1) : 0];
	reg [7:0] file_header_array [(BMP_HEADER_SIZE-1) : 0];
	//reg [7:0] DIB_header_array [(DIB_HEADER_C1_SIZE-1) : 0];
	reg [7:0] non_image_array [137:0];
	//integer ptr; // Debugging
	reg [7:0] non_image; // Debugging
	reg [7:0] image; // debugging

	// Tasks
	task extract_start_address;
		in_file = $fopen(INPUT_FILE_NAME, "r");
		for (i = 0; i < BMP_HEADER_SIZE; i += 1) // Extract file header information (DONE)
		begin
			quiet_catch = $fscanf(in_file, "%c", file_header_array[i]);
			//$info("file_header_array[%0d] = %0h", i, file_header_array[i]);
		end
		start_addr = int'(file_header_array[13:10]);
	endtask

	initial
	begin
		/*in_file = $fopen(INPUT_FILE_NAME, "rb");
		out_file = $fopen(OUTPUT_FILE_NAME, "wb");
		for (i = 0; i < 138; i++)
		begin
			quiet_catch = $fscanf(in_file, "%c", non_image);
			$fwrite(out_file, "%c", non_image);
		end

		for (i = 0; i < IMAGE_WIDTH*3; i++)
		begin
			$fwrite(out_file, "%c", 8'd255);
		end


		for (j = 1; j < IMAGE_HEIGHT-1; j++)
		begin
			$fseek(in_file, j*IMAGE_WIDTH, 0);
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
			for (i = 3; i < (IMAGE_WIDTH-1)*3; i++)
			begin
				quiet_catch = $fscanf(in_file, "%c", image);
				$fwrite(out_file, "%c", image);
				quiet_catch = $fscanf(in_file, "%c", image);
				$fwrite(out_file, "%c", image);
				quiet_catch = $fscanf(in_file, "%c", image);
				$fwrite(out_file, "%c", image);
			end
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
		end

		for (i = 0; i < IMAGE_WIDTH*3; i++)
		begin
			$fwrite(out_file, "%c", 8'd255);
		end*/
		extract_start_address;
		
		out_file = $fopen(OUTPUT_FILE_NAME, "w");
		// Jump through all non image elements (DONE)
		quiet_catch = $fseek(in_file, 0, 0);
		for (i = 0; i < start_addr; i += 1)
		begin
			quiet_catch = $fscanf(in_file, "%c", non_image);
			$fwrite(out_file, "%c", non_image);
			//$info("non_image_array[%0d] = %0d", i, non_image_array[i]);
		end

		// Extract picture pixels (DONE)
		for (i = 0; i < IMAGE_WIDTH*IMAGE_HEIGHT; i += 1)
		begin
			image_array[i] = 0;
			quiet_catch = $fscanf(in_file, "%c", image);
			image_array[i] += image;
			quiet_catch = $fscanf(in_file, "%c", image);
			image_array[i] += image;
			quiet_catch = $fscanf(in_file, "%c", image);
			image_array[i] += image;
			image_array[i] /= 3;
			//$fseek(in_file, 2, 1);
		end

		$fclose(INPUT_FILE_NAME);
		// File -> "SRAM" done


		/*out_file = $fopen(OUTPUT_FILE_NAME, "wb");
		for (i = 0; i < start_addr; i += 1)
		begin
			$fwrite(out_file, "%c", non_image_array[i]);
		end*/
		// SRAM -> Top Level

			tb_n_rst = 1;
			@(posedge tb_clk);
			tb_n_rst = 0;
			@(posedge tb_clk);
			tb_n_rst = 1;
			@(posedge tb_clk);

		for (j = 0; j <= (IMAGE_WIDTH-3) * (IMAGE_HEIGHT-2); j += 1)
		begin

			tb_HREADY_M = 0;
			tb_HADDR_S = SOURCE_ADDR;
			tb_HREADY_S = 0;
			tb_HWDATA_S = (IMAGE_WIDTH << 16) | IMAGE_HEIGHT;
			tb_HWRITE_S = 0;
			@(posedge tb_clk); // IDLE
			tb_HREADY_S = 1;
			@(posedge tb_clk); // IDLE (SLAVE)
			@(posedge tb_clk); // DECODE_SIZE (SLAVE)
			@(posedge tb_clk); // SOURCE_DECODE (SLAVE)
			tb_HADDR_S = DEST_ADDR;
			@(posedge tb_clk); // DEST_DECODE (SLAVE)
			@(posedge tb_clk); // IDLE (MASTER)
			tb_HREADY_M = 1;
			@(posedge tb_clk); // IDLE (MASTER)
			@(posedge tb_clk); // READY (MASTER)
			@(posedge tb_clk); // READ_ADDR_1 (MASTER)
			tb_HRDATA_M = (image_array[tb_HADDR_M] << 24) | (image_array[tb_HADDR_M + 1] << 16) | (image_array[tb_HADDR_M + 2] << 8) | image_array[tb_HADDR_M + 3];
			@(posedge tb_clk); // READ_DATA_1 (MASTER)
			@(posedge tb_clk); // SHIFT_1 (MASTER) (MCU: READ1)
			@(posedge tb_clk);
			@(posedge tb_clk);
			@(posedge tb_clk); // BUFFER[0 to 3] filled
			

			@(posedge tb_clk); // READ_ADDR_2 (MASTER)
			tb_HRDATA_M = (image_array[tb_HADDR_M] << 24) | (image_array[tb_HADDR_M + 1] << 16) | (image_array[tb_HADDR_M + 2] << 8) | image_array[tb_HADDR_M + 3];
			@(posedge tb_clk); // READ_DATA_2 (MASTER)
			@(posedge tb_clk); // SHIFT_2 (MASTER) (MCU: READ2)
			@(posedge tb_clk);
			@(posedge tb_clk);
			@(posedge tb_clk); // BUFFER[4 to 7] filled
			

			@(posedge tb_clk); // READ_ADDR_3 (MASTER)
			tb_HRDATA_M = (image_array[tb_HADDR_M] << 24) | (image_array[tb_HADDR_M + 1] << 16) | (image_array[tb_HADDR_M + 2] << 8) | image_array[tb_HADDR_M + 3];
			@(posedge tb_clk); // READ_DATA_3 (MASTER)
			@(posedge tb_clk); // SHIFT_3 (MASTER) (MCU: READ3)
			@(posedge tb_clk);
			@(posedge tb_clk);
			@(posedge tb_clk); // BUFFER[8 to 11] filled
			@(posedge tb_clk); // ADDRESS_UPDATE_R (MASTER)
			//@(posedge tb_clk); 

			tb_HWRITE_S = 1;
			@(posedge tb_clk); // IDLE (MASTER) CALCULATE (MCU)
			@(posedge tb_clk); // READY (MASTER) WAIT (MCU)

			@(posedge tb_clk); // WRITE_ADDR (MASTER) WRITE (MCU)
			@(posedge tb_clk); // WRITE_DATA (MASTER)
			image_array[tb_HADDR_M] = tb_HWDATA_M[15:8];
			image_array[tb_HADDR_M + 1] = tb_HWDATA_M[7:0];
			@(posedge tb_clk); // ADDR_UPDATE_W (MASTER)
			


			//$info("write");
		end

		for (i = 0; i < IMAGE_WIDTH; i += 1)
		begin
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
		end

		for (j = 1; j < IMAGE_HEIGHT - 1; j += 1)
		begin
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
			for (i = 1; i < (IMAGE_WIDTH - 1) ; i++)
			begin
				//$fwrite(out_file, "%c", image_array[DEST_ADDR + (j - 1)*IMAGE_WIDTH + (i - 1)]);
				//$fwrite(out_file, "%c", image_array[DEST_ADDR + (j - 1)*IMAGE_WIDTH + (i - 1)]);
				//$fwrite(out_file, "%c", image_array[DEST_ADDR + (j - 1)*IMAGE_WIDTH + (i - 1)]);
				$fwrite(out_file, "%c", image_array[DEST_ADDR + (j - 1)*IMAGE_WIDTH + (i - 1) + 1]);
				$fwrite(out_file, "%c", image_array[DEST_ADDR + (j - 1)*IMAGE_WIDTH + (i - 1) + 1]);
				$fwrite(out_file, "%c", image_array[DEST_ADDR + (j - 1)*IMAGE_WIDTH + (i - 1) + 1]);
			end
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
		end


		
		for (i = 0; i < IMAGE_WIDTH; i += 1)
		begin
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
			$fwrite(out_file, "%c", 8'd255);
		end
		$info("image_array[%d] = %0h", 200000, image_array[200000]);
		$info("image_array[%d] = %0h", 200001, image_array[200001]);
		$info("image_array[%d] = %0h", 200002, image_array[200002]);
		$info("image_array[%d] = %0h", 200003, image_array[200003]);
		$fclose(out_file);
	end
endmodule
