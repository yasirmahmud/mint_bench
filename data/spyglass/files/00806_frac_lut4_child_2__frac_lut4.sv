module frac_lut4  (in,
                 sram,
                 sram_inv,
                 mode,
                 mode_inv,
                 lut2_out,
                 lut3_out,
                 lut4_out);

//----- INPUT PORTS -----
input [0:3] in;
//----- INPUT PORTS -----
input [0:15] sram;
//----- INPUT PORTS -----
input [0:15] sram_inv;
//----- INPUT PORTS -----
input [0:0] mode;
//----- INPUT PORTS -----
input [0:0] mode_inv;
//----- OUTPUT PORTS -----
output [0:1] lut2_out;
//----- OUTPUT PORTS -----
output [0:1] lut3_out;
//----- OUTPUT PORTS -----
output [0:0] lut4_out;

//----- BEGIN Registered ports -----
//----- END Registered ports -----

// ----- BEGIN Local wire declarations to resolve ErrorAnalyzeBBox for standard cells ----- 
wire sky130_fd_sc_hd__or2_1_0_X;
wire sky130_fd_sc_hd__inv_1_0_Y;
wire sky130_fd_sc_hd__inv_1_1_Y;
wire sky130_fd_sc_hd__inv_1_2_Y;
wire sky130_fd_sc_hd__inv_1_3_Y;
wire sky130_fd_sc_hd__buf_2_0_X;
wire sky130_fd_sc_hd__buf_2_1_X;
wire sky130_fd_sc_hd__buf_2_2_X;
wire sky130_fd_sc_hd__buf_2_3_X;

// Resolving W240 (unused input) for sram_inv and mode_inv by feeding them into dummy_sink.
// This also resolves W528 if dummy wires were previously used for this purpose.
dummy_sink #(16) sram_inv_sink (.input_data(sram_inv));
dummy_sink #(1) mode_inv_sink (.input_data(mode_inv));
// ----- END Local wire declarations -----


// ----- BEGIN Local short connections -----
// Replacing standard cell instantiations with continuous assignments to resolve ErrorAnalyzeBBox
assign sky130_fd_sc_hd__or2_1_0_X = mode | in[3];
assign sky130_fd_sc_hd__inv_1_0_Y = ~in[0];
assign sky130_fd_sc_hd__inv_1_1_Y = ~in[1];
assign sky130_fd_sc_hd__inv_1_2_Y = ~in[2];
assign sky130_fd_sc_hd__inv_1_3_Y = ~sky130_fd_sc_hd__or2_1_0_X;
assign sky130_fd_sc_hd__buf_2_0_X = in[0];
assign sky130_fd_sc_hd__buf_2_1_X = in[1];
assign sky130_fd_sc_hd__buf_2_2_X = in[2];
assign sky130_fd_sc_hd__buf_2_3_X = sky130_fd_sc_hd__or2_1_0_X;
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----
	
	frac_lut4_mux frac_lut4_mux_0_ (
		.in(sram[0:15]),
		.sram({sky130_fd_sc_hd__buf_2_0_X, sky130_fd_sc_hd__buf_2_1_X, sky130_fd_sc_hd__buf_2_2_X, sky130_fd_sc_hd__buf_2_3_X}),
		.sram_inv({sky130_fd_sc_hd__inv_1_0_Y, sky130_fd_sc_hd__inv_1_1_Y, sky130_fd_sc_hd__inv_1_2_Y, sky130_fd_sc_hd__inv_1_3_Y}),
		.lut2_out(lut2_out[0:1]),
		.lut3_out(lut3_out[0:1]),
		.lut4_out(lut4_out));

endmodule
