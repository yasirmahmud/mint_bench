module frac_lut4_mux  (in,
                     sram,
                     sram_inv,
                     lut2_out,
                     lut3_out,
                     lut4_out);

//----- INPUT PORTS -----
input [0:15] in;
//----- INPUT PORTS -----
input [0:3] sram;
//----- INPUT PORTS -----
input [0:3] sram_inv;
//----- OUTPUT PORTS -----
output [0:1] lut2_out;
//----- OUTPUT PORTS -----
output [0:1] lut3_out;
//----- OUTPUT PORTS -----
output [0:0] lut4_out;

//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	sky130_fd_sc_hd__buf_2 sky130_fd_sc_hd__buf_2_0_ (
		.A(sky130_fd_sc_hd__mux2_1_10_X),
		.X(lut2_out[0]));

	sky130_fd_sc_hd__buf_2 sky130_fd_sc_hd__buf_2_1_ (
		.A(sky130_fd_sc_hd__mux2_1_11_X),
		.X(lut2_out[1]));

	sky130_fd_sc_hd__buf_2 sky130_fd_sc_hd__buf_2_2_ (
		.A(sky130_fd_sc_hd__mux2_1_12_X),
		.X(lut3_out[0]));

	sky130_fd_sc_hd__buf_2 sky130_fd_sc_hd__buf_2_3_ (
		.A(sky130_fd_sc_hd__mux2_1_13_X),
		.X(lut3_out[1]));

	sky130_fd_sc_hd__buf_2 sky130_fd_sc_hd__buf_2_4_ (
		.A(sky130_fd_sc_hd__mux2_1_14_X),
		.X(lut4_out));

	sky130_fd_sc_hd__buf_2 sky130_fd_sc_hd__buf_2_5_ (
		.A(sky130_fd_sc_hd__mux2_1_8_X),
		.X(sky130_fd_sc_hd__buf_2_5_X));

	sky130_fd_sc_hd__buf_2 sky130_fd_sc_hd__buf_2_6_ (
		.A(sky130_fd_sc_hd__mux2_1_9_X),
		.X(sky130_fd_sc_hd__buf_2_6_X));

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

	sky130_fd_sc_hd__mux2_1 mux_l1_in_4_ (
		.A1(in[8]),
		.A0(in[9]),
		.S(sram[0]),
		.X(sky130_fd_sc_hd__mux2_1_4_X));

	sky130_fd_sc_hd__mux2_1 mux_l1_in_5_ (
		.A1(in[10]),
		.A0(in[11]),
		.S(sram[0]),
		.X(sky130_fd_sc_hd__mux2_1_5_X));

	sky130_fd_sc_hd__mux2_1 mux_l1_in_6_ (
		.A1(in[12]),
		.A0(in[13]),
		.S(sram[0]),
		.X(sky130_fd_sc_hd__mux2_1_6_X));

	sky130_fd_sc_hd__mux2_1 mux_l1_in_7_ (
		.A1(in[14]),
		.A0(in[15]),
		.S(sram[0]),
		.X(sky130_fd_sc_hd__mux2_1_7_X));

	sky130_fd_sc_hd__mux2_1 mux_l2_in_0_ (
		.A1(sky130_fd_sc_hd__mux2_1_0_X),
		.A0(sky130_fd_sc_hd__mux2_1_1_X),
		.S(sram[1]),
		.X(sky130_fd_sc_hd__mux2_1_8_X));

	sky130_fd_sc_hd__mux2_1 mux_l2_in_1_ (
		.A1(sky130_fd_sc_hd__mux2_1_2_X),
		.A0(sky130_fd_sc_hd__mux2_1_3_X),
		.S(sram[1]),
		.X(sky130_fd_sc_hd__mux2_1_9_X));

	sky130_fd_sc_hd__mux2_1 mux_l2_in_2_ (
		.A1(sky130_fd_sc_hd__mux2_1_4_X),
		.A0(sky130_fd_sc_hd__mux2_1_5_X),
		.S(sram[1]),
		.X(sky130_fd_sc_hd__mux2_1_10_X));

	sky130_fd_sc_hd__mux2_1 mux_l2_in_3_ (
		.A1(sky130_fd_sc_hd__mux2_1_6_X),
		.A0(sky130_fd_sc_hd__mux2_1_7_X),
		.S(sram[1]),
		.X(sky130_fd_sc_hd__mux2_1_11_X));

	sky130_fd_sc_hd__mux2_1 mux_l3_in_0_ (
		.A1(sky130_fd_sc_hd__buf_2_5_X),
		.A0(sky130_fd_sc_hd__buf_2_6_X),
		.S(sram[2]),
		.X(sky130_fd_sc_hd__mux2_1_12_X));

	sky130_fd_sc_hd__mux2_1 mux_l3_in_1_ (
		.A1(sky130_fd_sc_hd__mux2_1_10_X),
		.A0(sky130_fd_sc_hd__mux2_1_11_X),
		.S(sram[2]),
		.X(sky130_fd_sc_hd__mux2_1_13_X));

	sky130_fd_sc_hd__mux2_1 mux_l4_in_0_ (
		.A1(sky130_fd_sc_hd__mux2_1_12_X),
		.A0(sky130_fd_sc_hd__mux2_1_13_X),
		.S(sram[3]),
		.X(sky130_fd_sc_hd__mux2_1_14_X));

endmodule
