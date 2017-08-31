onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_fill_in_buffer/tb_clk
add wave -noupdate /tb_fill_in_buffer/tb_n_rst
add wave -noupdate /tb_fill_in_buffer/tb_shift_enable
add wave -noupdate /tb_fill_in_buffer/tb_buffer_clear
add wave -noupdate -radix hexadecimal /tb_fill_in_buffer/tb_read_data
add wave -noupdate /tb_fill_in_buffer/tb_buffer_full
add wave -noupdate /tb_fill_in_buffer/tb_buffer_empty
add wave -noupdate -radix hexadecimal /tb_fill_in_buffer/tb_data_buffer
add wave -noupdate -radix unsigned /tb_fill_in_buffer/DUT/pixel_count
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -radix decimal /tb_fill_in_buffer/DUT/pixel_count
add wave -noupdate -radix hexadecimal /tb_fill_in_buffer/DUT/buffer_full
add wave -noupdate -radix hexadecimal /tb_fill_in_buffer/DUT/buffer_empty
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4367 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 178
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
WaveRestoreZoom {0 ps} {16820 ps}
