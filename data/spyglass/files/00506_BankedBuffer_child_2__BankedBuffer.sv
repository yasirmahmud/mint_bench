module BankedBuffer  (
	clk,
	rst,
	data_in,
	addr,
	state,
	data_out
);

	parameter ARR_SIZE = 4;
	input wire clk;
	input wire rst;
	input wire [31:0] data_in;
	input wire [6:0] addr;
	input wire [1:0] state;
	output reg [(ARR_SIZE * 16) - 1:0] data_out;
	wire [(ARR_SIZE * 16) - 1:0] op_wire;
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < ARR_SIZE; _gv_i_1 = _gv_i_1 + 1) begin : module_instances
			// The localparam 'i' is replaced directly by the genvar '_gv_i_1' to avoid STX_VE_479 violation
			individual_buffer inst(
				.clk(clk),
				.rst(rst),
				.individual_input((addr == _gv_i_1 ? data_in[15:0] : (addr == (_gv_i_1 - 1) ? data_in[31:16] : 16'b0000000000000000))),
				.state((state != 2'b01 ? (addr == _gv_i_1 ? state : 2'b00) : state)),
				.individual_output(op_wire[((_gv_i_1 + 1) * 16) - 1:_gv_i_1 * 16])
			);
		end
	endgenerate
	always @(posedge clk) data_out <= op_wire;
endmodule
