module inc_dec_30 (

	operand,
	result,
	control
);

input	[29:0]	operand;
output	[29:0]	result;
input	[1:0]	control;

wire	[29:0]	neg_one;
wire		NC0,NC1,NC2;

assign	neg_one	= {30{control[0]}};

cla_adder_32 adder ( .in1({2'b00,operand}),
		.in2({2'b00,neg_one}),
		.cin(control[1]),
		.sum({NC2,NC1,result}),
		.cout(NC0) );

endmodule
