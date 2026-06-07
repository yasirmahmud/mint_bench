module rsd_dec (
	input [7:0] opcode,
	input [2:0] valid,
	output [4:0] offset_sel_rsd
);
	// Dummy assignment to resolve black-box errors
	assign offset_sel_rsd = 5'b0;
endmodule
