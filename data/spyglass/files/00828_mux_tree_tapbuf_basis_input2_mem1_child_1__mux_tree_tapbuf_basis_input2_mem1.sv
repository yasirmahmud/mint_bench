module mux_tree_tapbuf_basis_input2_mem1  (in,
                                         mem,
                                         mem_inv,
                                         out);

//----- INPUT PORTS -----
input [0:1] in;
//----- INPUT PORTS -----
input [0:0] mem;
//----- INPUT PORTS -----
input [0:0] mem_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	TGATE TGATE_0_ (
		.A(in[0]),
		.S(mem),
		.SI(mem_inv),
		.Y(out));

	TGATE TGATE_1_ (
		.A(in[1]),
		.S(mem_inv),
		.SI(mem),
		.Y(out));

endmodule
