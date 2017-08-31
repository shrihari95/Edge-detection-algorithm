onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {AHB Slave} /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/HCLK
add wave -noupdate -expand -group {AHB Slave} /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/HRESETn
add wave -noupdate -expand -group {AHB Slave} /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/HREADY
add wave -noupdate -expand -group {AHB Slave} /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/HWRITE
add wave -noupdate -expand -group {AHB Slave} -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/HWDATA
add wave -noupdate -expand -group {AHB Slave} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/HADDR
add wave -noupdate -expand -group {AHB Slave} /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/status
add wave -noupdate -expand -group {AHB Slave} -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/length
add wave -noupdate -expand -group {AHB Slave} -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/width
add wave -noupdate -expand -group {AHB Slave} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/source_addr
add wave -noupdate -expand -group {AHB Slave} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/dest_addr
add wave -noupdate -expand -group {AHB Slave} /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/read_enable
add wave -noupdate -expand -group {AHB Slave} /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/write_enable
add wave -noupdate -expand -group {AHB Slave} /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/decode_size_enable
add wave -noupdate -expand -group {AHB Slave} /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/decode_source_enable
add wave -noupdate -expand -group {AHB Slave} /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/decode_dest_enable
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/HCLK
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/HRESETn
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/HREADY
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/read_enable
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/write_enable
add wave -noupdate -expand -group {AHB Master} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/length
add wave -noupdate -expand -group {AHB Master} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/width
add wave -noupdate -expand -group {AHB Master} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/source_addr
add wave -noupdate -expand -group {AHB Master} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/dest_addr
add wave -noupdate -expand -group {AHB Master} -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/HRDATA
add wave -noupdate -expand -group {AHB Master} -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/sobel_result1
add wave -noupdate -expand -group {AHB Master} -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/sobel_result2
add wave -noupdate -expand -group {AHB Master} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/HADDR
add wave -noupdate -expand -group {AHB Master} -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/pixel_out
add wave -noupdate -expand -group {AHB Master} -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/HWDATA
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/HWRITE
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/transfer_data_complete_r
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/transfer_data_complete_w
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/shift_enable_r
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/transfer_addr_complete_r
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/transfer_addr_complete_w
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/end_of_image
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/addr_enable_r
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/load_enable_r
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/addr_update_enable_r
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/addr_enable_w
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/shift_enable_w
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/addr_update_enable_w
add wave -noupdate -expand -group {AHB Master} /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/plus4_r
add wave -noupdate -expand -group {AHB Master} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/start_addr
add wave -noupdate -expand -group {AHB Master} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/curr_addr_r
add wave -noupdate -expand -group {AHB Master} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/curr_addr_w
add wave -noupdate -expand -group {Data buffer} /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/clk
add wave -noupdate -expand -group {Data buffer} /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/n_rst
add wave -noupdate -expand -group {Data buffer} /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/shift_enable
add wave -noupdate -expand -group {Data buffer} /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/buffer_clear
add wave -noupdate -expand -group {Data buffer} -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/read_data
add wave -noupdate -expand -group {Data buffer} -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/data_buffer
add wave -noupdate -expand -group {Data buffer} /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/buffer_full
add wave -noupdate -expand -group {Data buffer} /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/buffer_empty
add wave -noupdate -expand -group {Data buffer} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/pixel_count
add wave -noupdate -expand -group {Data buffer} -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/next_data_buffer
add wave -noupdate -expand -group {Edge detection module} /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/clk
add wave -noupdate -expand -group {Edge detection module} /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/n_rst
add wave -noupdate -expand -group {Edge detection module} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/data_buffer
add wave -noupdate -expand -group {Edge detection module} /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/shift_enable_r
add wave -noupdate -expand -group {Edge detection module} /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/transfer_data_complete_r
add wave -noupdate -expand -group {Edge detection module} /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/transfer_data_complete_w
add wave -noupdate -expand -group {Edge detection module} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/final_out_1
add wave -noupdate -expand -group {Edge detection module} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/final_out_2
add wave -noupdate -expand -group {Edge detection module} /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/buffer_clear
add wave -noupdate -expand -group {Edge detection module} /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/enable_calc
add wave -noupdate -expand -group {Edge detection module} -radix decimal /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/gx_out_1
add wave -noupdate -expand -group {Edge detection module} -radix decimal /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/gx_out_2
add wave -noupdate -expand -group {Edge detection module} -radix decimal /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/gy_out_1
add wave -noupdate -expand -group {Edge detection module} -radix decimal /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/gy_out_2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {364167 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2904320 ps}
