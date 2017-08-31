onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_ahb_master/tb_HCLK
add wave -noupdate /tb_ahb_master/tb_HRESETn
add wave -noupdate /tb_ahb_master/tb_HREADY
add wave -noupdate /tb_ahb_master/tb_read_enable
add wave -noupdate /tb_ahb_master/tb_write_enable
add wave -noupdate -radix unsigned /tb_ahb_master/tb_length
add wave -noupdate -radix unsigned /tb_ahb_master/tb_width
add wave -noupdate -radix unsigned /tb_ahb_master/tb_source_addr
add wave -noupdate -radix unsigned /tb_ahb_master/tb_dest_addr
add wave -noupdate -radix hexadecimal /tb_ahb_master/tb_HRDATA
add wave -noupdate -radix hexadecimal /tb_ahb_master/tb_sobel_result1
add wave -noupdate -radix hexadecimal /tb_ahb_master/tb_sobel_result2
add wave -noupdate -radix unsigned /tb_ahb_master/tb_HADDR
add wave -noupdate -radix hexadecimal /tb_ahb_master/tb_pixel_out
add wave -noupdate -radix hexadecimal /tb_ahb_master/tb_HWDATA
add wave -noupdate /tb_ahb_master/tb_HWRITE
add wave -noupdate /tb_ahb_master/tb_transfer_data_complete_r
add wave -noupdate /tb_ahb_master/tb_transfer_data_complete_w
add wave -noupdate /tb_ahb_master/tb_shift_enable_r
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/read_enable
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/write_enable
add wave -noupdate -radix unsigned /tb_ahb_master/DUT_AHB_BLOCK/length
add wave -noupdate -radix unsigned /tb_ahb_master/DUT_AHB_BLOCK/width
add wave -noupdate -radix unsigned /tb_ahb_master/DUT_AHB_BLOCK/source_addr
add wave -noupdate -radix unsigned /tb_ahb_master/DUT_AHB_BLOCK/dest_addr
add wave -noupdate -radix hexadecimal /tb_ahb_master/DUT_AHB_BLOCK/HRDATA
add wave -noupdate -radix hexadecimal /tb_ahb_master/DUT_AHB_BLOCK/sobel_result1
add wave -noupdate -radix hexadecimal /tb_ahb_master/DUT_AHB_BLOCK/sobel_result2
add wave -noupdate -radix unsigned /tb_ahb_master/DUT_AHB_BLOCK/HADDR
add wave -noupdate -radix unsigned /tb_ahb_master/DUT_AHB_BLOCK/start_addr
add wave -noupdate -radix hexadecimal /tb_ahb_master/DUT_AHB_BLOCK/pixel_out
add wave -noupdate -radix hexadecimal /tb_ahb_master/DUT_AHB_BLOCK/HWDATA
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/transfer_addr_complete_r
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/transfer_data_complete_r
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/transfer_addr_complete_w
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/transfer_data_complete_w
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/end_of_image
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/addr_enable_r
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/load_enable_r
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/shift_enable_r
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/addr_update_enable_r
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/addr_enable_w
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/shift_enable_w
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/addr_update_enable_w
add wave -noupdate -radix unsigned /tb_ahb_master/DUT_AHB_BLOCK/curr_addr_r
add wave -noupdate -radix unsigned /tb_ahb_master/DUT_AHB_BLOCK/curr_addr_w
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/HREADY
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/AHB_CONTROLLER/state
add wave -noupdate /tb_ahb_master/DUT_AHB_BLOCK/AHB_CONTROLLER/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {89401 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 219
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
WaveRestoreZoom {376470 ps} {465871 ps}
