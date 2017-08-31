onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_address_update_w/tb_HCLK
add wave -noupdate /tb_address_update_w/tb_HRESETn
add wave -noupdate /tb_address_update_w/tb_status
add wave -noupdate -radix unsigned /tb_address_update_w/tb_length
add wave -noupdate -radix unsigned /tb_address_update_w/tb_width
add wave -noupdate -radix unsigned /tb_address_update_w/tb_addr
add wave -noupdate /tb_address_update_w/tb_addr_update_enable_w
add wave -noupdate -radix unsigned /tb_address_update_w/tb_curr_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17917 ps} 0}
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
