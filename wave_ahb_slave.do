onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_ahb_slave/tb_HCLK
add wave -noupdate /tb_ahb_slave/tb_HRESETn
add wave -noupdate /tb_ahb_slave/tb_status
add wave -noupdate /tb_ahb_slave/tb_HREADY
add wave -noupdate /tb_ahb_slave/tb_HWRITE
add wave -noupdate -radix hexadecimal /tb_ahb_slave/tb_HWDATA
add wave -noupdate -radix hexadecimal /tb_ahb_slave/tb_HADDR
add wave -noupdate -radix hexadecimal /tb_ahb_slave/tb_length
add wave -noupdate -radix hexadecimal /tb_ahb_slave/tb_width
add wave -noupdate -radix hexadecimal /tb_ahb_slave/tb_source_addr
add wave -noupdate -radix hexadecimal /tb_ahb_slave/tb_dest_addr
add wave -noupdate /tb_ahb_slave/tb_read_enable
add wave -noupdate /tb_ahb_slave/tb_write_enable
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /tb_ahb_slave/DUT_AHB_SLAVE/decode_size_enable
add wave -noupdate /tb_ahb_slave/DUT_AHB_SLAVE/decode_source_enable
add wave -noupdate /tb_ahb_slave/DUT_AHB_SLAVE/decode_dest_enable
add wave -noupdate /tb_ahb_slave/DUT_AHB_SLAVE/AHB_SLAVE_CONTROLLER/state
add wave -noupdate /tb_ahb_slave/DUT_AHB_SLAVE/AHB_SLAVE_CONTROLLER/next_state
add wave -noupdate -radix hexadecimal /tb_ahb_slave/DUT_AHB_SLAVE/AHB_SLAVE_DECODER/next_source_addr
add wave -noupdate -radix hexadecimal /tb_ahb_slave/DUT_AHB_SLAVE/AHB_SLAVE_DECODER/source_addr
add wave -noupdate -radix hexadecimal /tb_ahb_slave/DUT_AHB_SLAVE/AHB_SLAVE_DECODER/next_dest_addr
add wave -noupdate -radix hexadecimal /tb_ahb_slave/DUT_AHB_SLAVE/AHB_SLAVE_DECODER/dest_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21454 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {64 ns}
