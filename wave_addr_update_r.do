onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_address_update_r/tb_HCLK
add wave -noupdate /tb_address_update_r/tb_HRESETn
add wave -noupdate -radix unsigned /tb_address_update_r/tb_length
add wave -noupdate -radix unsigned /tb_address_update_r/tb_width
add wave -noupdate -radix unsigned /tb_address_update_r/tb_addr
add wave -noupdate /tb_address_update_r/tb_addr_update_enable_r
add wave -noupdate -radix unsigned /tb_address_update_r/tb_curr_addr
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -radix unsigned /tb_address_update_r/DUT_ADDRESS_UPDATE/row_count
add wave -noupdate -radix unsigned /tb_address_update_r/DUT_ADDRESS_UPDATE/column_count
add wave -noupdate /tb_address_update_r/DUT_ADDRESS_UPDATE/end_of_image
add wave -noupdate /tb_address_update_r/DUT_ADDRESS_UPDATE/last_possible_row
add wave -noupdate /tb_address_update_r/DUT_ADDRESS_UPDATE/plus4_r
add wave -noupdate /tb_address_update_r/DUT_ADDRESS_UPDATE/update_en_r
add wave -noupdate /tb_address_update_r/DUT_ADDRESS_UPDATE/status
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1047389 ps} 0}
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
WaveRestoreZoom {956800 ps} {1212800 ps}
