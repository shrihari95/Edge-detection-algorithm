onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_fifo_r/tb_HCLK
add wave -noupdate /tb_fifo_r/tb_HRESETn
add wave -noupdate /tb_fifo_r/tb_status
add wave -noupdate /tb_fifo_r/tb_shift_enable
add wave -noupdate /tb_fifo_r/tb_load_enable
add wave -noupdate -radix hexadecimal /tb_fifo_r/tb_data_in
add wave -noupdate /tb_fifo_r/tb_transfer_data_complete_r
add wave -noupdate -radix hexadecimal /tb_fifo_r/tb_HRDATA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {199694 ps} 0}
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
WaveRestoreZoom {139200 ps} {203200 ps}
