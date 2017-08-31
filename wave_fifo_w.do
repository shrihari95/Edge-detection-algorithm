onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_fifo_w/tb_HCLK
add wave -noupdate /tb_fifo_w/tb_HRESETn
add wave -noupdate /tb_fifo_w/tb_status
add wave -noupdate /tb_fifo_w/tb_shift_enable
add wave -noupdate -radix hexadecimal /tb_fifo_w/tb_data_out_1
add wave -noupdate -radix hexadecimal /tb_fifo_w/tb_data_out_2
add wave -noupdate -radix hexadecimal /tb_fifo_w/tb_HWDATA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40224 ps} 0}
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
WaveRestoreZoom {0 ps} {128 ns}
