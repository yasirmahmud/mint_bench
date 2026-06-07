module rsd_dec (
	input [7:0] opcode,
	input [2:0] valid,
	output [4:0] offset_sel_rsd
);
	// Read unused inputs to resolve W240 violations while preserving dummy assignments
	wire [7:0] unused_opcode_rsd = opcode;
	wire [2:0] unused_valid_rsd = valid;

	// Dummy assignment to resolve black-box errors
	assign offset_sel_rsd = 5'b0;
endmodule
