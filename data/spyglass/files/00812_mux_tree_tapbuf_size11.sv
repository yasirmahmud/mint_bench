module mux_tree_tapbuf_size11  (in,
                              sram,
                              sram_inv,
                              out);

//----- INPUT PORTS -----
input [0:10] in;
//----- INPUT PORTS -----
input [0:3] sram;
//----- INPUT PORTS -----
input [0:3] sram_inv;
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
		.A(sky130_fd_sc_hd__mux2_1_10_X),
		.X(out));

	sky130_fd_sc_hd__mux2_1 mux_l1_in_0_ (
		.A1(in[0]),
		.A0(in[1]),
		.S(sram[0]),
		.X(sky130_fd_sc_hd__mux2_1_0_X));

	sky130_fd_sc_hd__mux2_1 mux_l1_in_1_ (
		.A1(in[2]),
		.A0(in[3]),
		.S(sram[0]),
		.X(sky130_fd_sc_hd__mux2_1_1_X));

	sky130_fd_sc_hd__mux2_1 mux_l1_in_2_ (
		.A1(in[4]),
		.A0(in[5]),
		.S(sram[0]),
		.X(sky130_fd_sc_hd__mux2_1_2_X));

	sky130_fd_sc_hd__mux2_1 mux_l1_in_3_ (
		.A1(in[6]),
		.A0(in[7]),
		.S(sram[0]),
		.X(sky130_fd_sc_hd__mux2_1_3_X));

	sky130_fd_sc_hd__mux2_1 mux_l2_in_0_ (
		.A1(sky130_fd_sc_hd__mux2_1_0_X),
		.A0(sky130_fd_sc_hd__mux2_1_1_X),
		.S(sram[1]),
		.X(sky130_fd_sc_hd__mux2_1_4_X));

	sky130_fd_sc_hd__mux2_1 mux_l2_in_1_ (
		.A1(sky130_fd_sc_hd__mux2_1_2_X),
		.A0(sky130_fd_sc_hd__mux2_1_3_X),
		.S(sram[1]),
		.X(sky130_fd_sc_hd__mux2_1_5_X));

	sky130_fd_sc_hd__mux2_1 mux_l2_in_2_ (
		.A1(in[8]),
		.A0(in[9]),
		.S(sram[1]),
		.X(sky130_fd_sc_hd__mux2_1_6_X));

	sky130_fd_sc_hd__mux2_1 mux_l2_in_3_ (
		.A1(in[10]),
		.A0(const1_0_const1),
		.S(sram[1]),
		.X(sky130_fd_sc_hd__mux2_1_7_X));

	sky130_fd_sc_hd__mux2_1 mux_l3_in_0_ (
		.A1(sky130_fd_sc_hd__mux2_1_4_X),
		.A0(sky130_fd_sc_hd__mux2_1_5_X),
		.S(sram[2]),
		.X(sky130_fd_sc_hd__mux2_1_8_X));

	sky130_fd_sc_hd__mux2_1 mux_l3_in_1_ (
		.A1(sky130_fd_sc_hd__mux2_1_6_X),
		.A0(sky130_fd_sc_hd__mux2_1_7_X),
		.S(sram[2]),
		.X(sky130_fd_sc_hd__mux2_1_9_X));

	sky130_fd_sc_hd__mux2_1 mux_l4_in_0_ (
		.A1(sky130_fd_sc_hd__mux2_1_8_X),
		.A0(sky130_fd_sc_hd__mux2_1_9_X),
		.S(sram[3]),
		.X(sky130_fd_sc_hd__mux2_1_10_X));

endmodule
