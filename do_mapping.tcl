# Step 1:  Read in the source file
analyze -format sverilog -lib WORK {ahb_master.sv ahb_slave.sv fill_in_buffer.sv overall_edge_det.sv flex_counter.sv flex_counter2.sv controller_ahb.sv address_update_r.sv get_address_r.sv fifo_r.sv address_update_w.sv fifo_w.sv controller_ahb_slave.sv decoder_ahb.sv mcu.sv gx_block_window1.sv gx_block_window2.sv gy_block_window1.sv gy_block_window2.sv result_1.sv result_2.sv top_level.sv}
elaborate top_level -lib WORK
uniquify
# Step 2: Set design constraints
# Uncomment below to set timing, area, power, etc. constraints
# set_max_delay <delay> -from "<input>" -to "<output>"
# set_max_area <area>
# set_max_total_power <power> mW
 create_clock "clk" -name "clk" -period 40

# Step 3: Compile the design
compile -map_effort medium

# Step 4: Output reports
report_timing -path full -delay max -max_paths 1 -nworst 1 > reports/top_level.rep
report_area >> reports/top_level.rep
report_power -hier >> reports/top_level.rep

# Step 5: Output final VHDL and Verilog files
write_file -format verilog -hierarchy -output "mapped/top_level.v"
echo "\nScript Done\n"
echo "\nChecking Design\n"
check_design
quit
