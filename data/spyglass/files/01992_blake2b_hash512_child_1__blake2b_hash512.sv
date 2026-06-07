module blake2b_hash512(
	input clk,
	input nreset,
	input          valid_i,
	input [1023:0] data_i,
	output         hash_v_o,
	output [511:0] hash_o // Seed, output of the hast512
	);
	blake2 #( .NN(64), .NN_b(8'b0100_0000)) m_hash512(
		.clk(clk),
		.nreset(nreset),
		.valid_i(valid_i),
		.d_i(data_i),
		.valid_o(hash_v_o),
		.h_o(hash_o)
	);
endmodule
