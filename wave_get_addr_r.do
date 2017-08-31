onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_get_address_r/tb_HCLK
add wave -noupdate /tb_get_address_r/tb_HRESETn
add wave -noupdate /tb_get_address_r/tb_status
add wave -noupdate /tb_get_address_r/tb_addr_enable_r
add wave -noupdate -radix unsigned /tb_get_address_r/tb_curr_addr
add wave -noupdate -radix unsigned /tb_get_address_r/tb_length
add wave -noupdate -radix unsigned /tb_get_address_r/tb_width
add wave -noupdate -radix unsigned /tb_get_address_r/tb_start_addr_r
add wave -noupdate /tb_get_address_r/tb_transfer_addr_complete_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {299738 ps} 0}
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
WaveRestoreZoom {0 ps} {256 ns}
