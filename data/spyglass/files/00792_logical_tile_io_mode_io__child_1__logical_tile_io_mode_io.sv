module logical_tile_io_mode_io_  (isol_n,
                                pReset,
                                prog_clk,
                                gfpga_pad_io_soc_in,
                                gfpga_pad_io_soc_out,
                                gfpga_pad_io_soc_dir,
                                io_outpad,
                                ccff_head,
                                io_inpad,
                                ccff_tail);

//----- GLOBAL PORTS -----
input [0:0] isol_n;
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- GPIN PORTS -----
input [0:0] gfpga_pad_io_soc_in;
//----- GPOUT PORTS -----
output [0:0] gfpga_pad_io_soc_out;
//----- GPOUT PORTS -----
output [0:0] gfpga_pad_io_soc_dir;
//----- INPUT PORTS -----
input [0:0] io_outpad;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] io_inpad;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
wire [0:0] direct_interc_1_out;
wire [0:0] logical_tile_io_mode_physical__iopad_0_iopad_inpad;
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_io_mode_physical__iopad logical_tile_io_mode_physical__iopad_0 (
		.isol_n(isol_n),
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_io_soc_in(gfpga_pad_io_soc_in),
		.gfpga_pad_io_soc_out(gfpga_pad_io_soc_out),
		.gfpga_pad_io_soc_dir(gfpga_pad_io_soc_dir),
		.iopad_outpad(direct_interc_1_out),
		.ccff_head(ccff_head),
		.iopad_inpad(logical_tile_io_mode_physical__iopad_0_iopad_inpad),
		.ccff_tail(ccff_tail));

	direct_interc direct_interc_0_ (
		.in(logical_tile_io_mode_physical__iopad_0_iopad_inpad),
		.out(io_inpad));

	direct_interc direct_interc_1_ (
		.in(io_outpad),
		.out(direct_interc_1_out));

endmodule
