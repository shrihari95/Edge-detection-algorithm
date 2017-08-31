onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_overall_edge_det/tb_data_buffer
add wave -noupdate /tb_overall_edge_det/tb_clk
add wave -noupdate /tb_overall_edge_det/tb_n_rst
add wave -noupdate /tb_overall_edge_det/tb_shift_enable_r
add wave -noupdate /tb_overall_edge_det/tb_transfer_data_complete_r
add wave -noupdate /tb_overall_edge_det/tb_transfer_data_complete_w
add wave -noupdate -radix unsigned /tb_overall_edge_det/tb_final_out_1
add wave -noupdate -radix unsigned /tb_overall_edge_det/tb_final_out_2
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /tb_overall_edge_det/overall/control/state
add wave -noupdate /tb_overall_edge_det/overall/control/next_state
add wave -noupdate /tb_overall_edge_det/overall/enable_calc
add wave -noupdate -radix decimal /tb_overall_edge_det/overall/gx_out_1
add wave -noupdate -radix decimal /tb_overall_edge_det/overall/gx_out_2
add wave -noupdate -radix decimal /tb_overall_edge_det/overall/gy_out_1
add wave -noupdate -radix decimal /tb_overall_edge_det/overall/gy_out_2
add wave -noupdate /tb_overall_edge_det/overall/buffer_clear
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19538 ps} 0}
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
