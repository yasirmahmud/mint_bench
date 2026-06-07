module mux_tree_tapbuf_size3  (in,
                             sram,
                             sram_inv,
                             out);

//----- INPUT PORTS -----
input [0:2] in;
//----- INPUT PORTS -----
input [0:1] sram;
//----- INPUT PORTS -----
input [0:1] sram_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	const1 const1_0_ (
		.const1(const1_0_const1));

	sky130_fd_sc_hd__buf_4 sky130_fd_sc_hd__buf_4_0_ (
		.A(sky130_fd_sc_hd__mux2_1_2_X),
		.X(out));

	sky130_fd_sc_hd__mux2_1 mux_l1_in_0_ (
		.A1(in[0]),
		.A0(in[1]),
		.S(sram[0]),
		.X(sky130_fd_sc_hd__mux2_1_0_X));

	sky130_fd_sc_hd__mux2_1 mux_l1_in_1_ (
		.A1(in[2]),
		.A0(const1_0_const1),
		.S(sram[0]),
		.X(sky130_fd_sc_hd__mux2_1_1_X));

	sky130_fd_sc_hd__mux2_1 mux_l2_in_0_ (
		.A1(sky130_fd_sc_hd__mux2_1_0_X),
		.A0(sky130_fd_sc_hd__mux2_1_1_X),
		.S(sram[1]),
		.X(sky130_fd_sc_hd__mux2_1_2_X));

endmodule
