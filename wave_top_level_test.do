onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top_level/tb_clk
add wave -noupdate /tb_top_level/tb_n_rst
add wave -noupdate /tb_top_level/tb_HWRITE_M
add wave -noupdate /tb_top_level/tb_HWRITE_S
add wave -noupdate /tb_top_level/tb_HREADY_M
add wave -noupdate /tb_top_level/tb_HREADY_S
add wave -noupdate -radix unsigned /tb_top_level/tb_HADDR_M
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/read_enable
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/write_enable
add wave -noupdate -radix unsigned /tb_top_level/tb_HADDR_S
add wave -noupdate -radix hexadecimal /tb_top_level/tb_HRDATA_M
add wave -noupdate -radix hexadecimal /tb_top_level/tb_HWDATA_M
add wave -noupdate -radix hexadecimal /tb_top_level/tb_HWDATA_S
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/data_buffer
add wave -noupdate -expand -group {Edge detection} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/final_out_1
add wave -noupdate -expand -group {Edge detection} -radix unsigned /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/final_out_2
add wave -noupdate -expand -group {Edge detection} -radix decimal /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/gx_out_1
add wave -noupdate -expand -group {Edge detection} -radix decimal /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/gx_out_2
add wave -noupdate -expand -group {Edge detection} -radix decimal /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/gy_out_1
add wave -noupdate -expand -group {Edge detection} -radix decimal /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/gy_out_2
add wave -noupdate /tb_top_level/in_file
add wave -noupdate /tb_top_level/out_file
add wave -noupdate /tb_top_level/i
add wave -noupdate /tb_top_level/j
add wave -noupdate /tb_top_level/quiet_catch
add wave -noupdate /tb_top_level/start_addr
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/end_of_image
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/state
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/next_state
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/AHB_SLAVE_CONTROLLER/state
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_SLAVE_PROTOCOL/AHB_SLAVE_CONTROLLER/next_state
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/transfer_addr_complete_r
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/transfer_data_complete_r
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/transfer_addr_complete_w
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/transfer_data_complete_w
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/addr_enable_r
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/load_enable_r
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/shift_enable_r
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/addr_update_enable_r
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/addr_enable_w
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/shift_enable_w
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/AHB_CONTROLLER/addr_update_enable_w
add wave -noupdate -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/source_addr
add wave -noupdate -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/dest_addr
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/control/state
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/EDGE_DETECTION_MODULE/control/next_state
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/buffer_full
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/DATA_BUFFER/buffer_empty
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/addr
add wave -noupdate -radix hexadecimal /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/addr_update_enable_r
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/curr_addr
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/end_of_image
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/last_possible_row
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/plus4_r
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/size
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/offset_r
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/next_offset_r
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/row_count
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/next_row_count
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/column_count
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_READ/next_column_count
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_WRITE/HCLK
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_WRITE/HRESETn
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_WRITE/length
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_WRITE/width
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_WRITE/addr_update_enable_w
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_WRITE/addr
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_WRITE/curr_addr
add wave -noupdate /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_WRITE/plus4_r
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_WRITE/offset_w
add wave -noupdate -radix unsigned /tb_top_level/DUT_TOP_LEVEL/AHB_MASTER_PROTOCOL/ADDRESS_UPDATE_WRITE/next_offset_w
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1451573 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 146
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {3117406 ps}
