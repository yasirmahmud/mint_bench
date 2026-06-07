module rs1_dec (
	input [15:0] opcode,
	input [2:0] valid,
	output valid_rs1,
	output [4:0] offset_sel_rs1,
	output mem_op,
	output help_rs1,
	output [7:0] type,
	output lv_rs1,
	output st_index_op,
	output update_optop,
	output reverse_ops,
	output lvars_acc_rs1
);
	// Read unused inputs to resolve W240 violations while preserving dummy assignments
	wire [15:0] unused_opcode_rs1 = opcode;
	wire [2:0] unused_valid_rs1 = valid;

	// Dummy assignments to resolve black-box errors
	assign valid_rs1 = 1'b0;
	assign offset_sel_rs1 = 5'b0;
	assign mem_op = 1'b0;
	assign help_rs1 = 1'b0;
	assign type = 8'b0;
	assign lv_rs1 = 1'b0;
	assign st_index_op = 1'b0;
	assign update_optop = 1'b0;
	assign reverse_ops = 1'b0;
	assign lvars_acc_rs1 = 1'b0;
endmodule
