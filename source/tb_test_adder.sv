// $Id: $
// File name:   tb_test_adder.sv
// Created:     3/16/2017
// Author:      Hengyi Lin
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Test bench of test_adder
module tb_test_adder();
	reg signed [3:0] test_a = -6;
	reg signed [3:0] test_b = -6;
	reg signed [4:0] test_c;
	test_adder FOUR_BIT_ADDER
	(
		.a(test_a), 
		.b(test_b), 
		.c(test_c)
	);
	
endmodule
