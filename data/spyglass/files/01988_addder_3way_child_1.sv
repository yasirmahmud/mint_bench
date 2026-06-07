module addder_3way #(
	parameter W=64
	)
	(
	input [W-1:0] x0_i,
	input [W-1:0] x1_i,
	input [W-1:0] x2_i,
	
	out put [W-1:0] y_o
	);
	wire         carry;
	wire [W-1:0] tmp;
	
	assign { carry , tmp } = x0_i + x1_i;
	assign y_o = x2_i + { carry , tmp };
endmodule
