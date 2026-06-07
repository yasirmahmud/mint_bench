module rs2_dec (
	input [15:0] opcode,
	input [2:0] valid,
	output lv_rs2,
	output lvars_acc_rs2,
	output [4:0] offset_sel_rs2
);
	// Read unused inputs to resolve W240 violations while preserving dummy assignments
	wire [15:0] unused_opcode_rs2 = opcode;
	wire [2:0] unused_valid_rs2 = valid;

	// Dummy assignments to resolve black-box errors
	assign lv_rs2 = 1'b0;
	assign lvars_acc_rs2 = 1'b0;
	assign offset_sel_rs2 = 5'b0;
endmodule
