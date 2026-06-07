module comp3_30 (

	openand1,
	openand2,
	signbit,
	result

);

input	[2:0]	openand1;
input	[29:0]	openand2;
input	signbit;
output	result;

wire	less;

less_comp3	comparator(.less(less),
		.in1(operand2[2:0]),
		.in2(operand1) );

assign result = ( signbit || ( (~|operand2[29:3]) && less) );

endmodule
