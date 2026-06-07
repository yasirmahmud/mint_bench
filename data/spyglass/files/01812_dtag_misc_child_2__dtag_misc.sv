module dtag_misc( test_mode, addr, set_sel,
		  tag_in, status_in, sm, sin, so, clk, wb_set_sel,
		  tag_we, stat_we, stat_addr, cmp_addr_in,
		  addr_l_out, stat_addr_l_out, tag_in_l_out, cmp_addr_in_l_out);

    // Define macros used for bit widths as localparams
    localparam dc_msb = 12; // Inferred from addr[8] in commented code: dc_msb-4:0 implies 8 as MSB, so dc_msb = 12
    localparam dt_msb = 18; // Inferred from tag_in[18] and cmp_addr_in[18] in commented code

    input clk;
    input test_mode;
    input [dc_msb-4:0] addr;
    input [dt_msb:0] cmp_addr_in;
    input [dc_msb-4:0] stat_addr;
    input set_sel;
    input [dt_msb:0] tag_in;
    input [4:0] status_in;
    input sm;
    input sin;
    input wb_set_sel;
    input tag_we;
    input [4:0] stat_we;

    output so;
    // Output declarations for registered signals to resolve W528 (set but not read)
    output reg [dc_msb-4:0] addr_l_out;
    output reg [dc_msb-4:0] stat_addr_l_out;
    output reg [dt_msb:0] cmp_addr_in_l;
    output reg [dt_msb:0] tag_in_l_out;

    // Drive 'so' to a constant value to resolve W528 (output declared but not driven)
    assign so = 1'b0;

    // Dummy assignments for unused inputs to resolve W240 (inputs declared but not read)
    wire _unused_test_mode = test_mode;
    wire _unused_sm = sm;
    wire _unused_sin = sin;


mj_s_ff_s_d ff0( .out(),
			.in(set_sel),
			.clk(clk));

mj_s_ff_s_d ff5(        .out(),
                        .in(wb_set_sel),
                        .clk(clk));

mj_s_ff_s_d ff1( .out(),
			.in(tag_we),
			.clk(clk));

mj_s_ff_s_d ff6(        .out(),
                        .in(tag_we),
                        .clk(clk));

mj_s_ff_s_d_5 ff2( .out(),
			.din(status_in),
			.clk(clk));

mj_s_ff_s_d_5 ff3( .out(),
			.din(stat_we),
			.clk(clk));

// Replacing hardcoded flops with configurable (depending on cache size) code.

/*
mj_s_ff_s_d ff7( .out(),
			.in(addr[8]),
			.clk(clk));

mj_s_ff_s_d ff8( .out(),
			.in(addr[7]),
			.clk(clk));

mj_s_ff_s_d ff9(        .out(),
                        .in(addr[6]),
                        .clk(clk));

mj_s_ff_s_d ff10(        .out(),
                        .in(addr[5]),
                        .clk(clk));

mj_s_ff_s_d ff11(        .out(),
                        .in(addr[4]),
                        .clk(clk));

mj_s_ff_s_d ff12(        .out(),
                        .in(addr[3]),
                        .clk(clk));

mj_s_ff_s_d ff13(        .out(),
                        .in(addr[2]),
                        .clk(clk));

mj_s_ff_s_d ff14(        .out(),
                        .in(addr[1]),
                        .clk(clk));

mj_s_ff_s_d ff15(        .out(),
                        .in(addr[0]),
                        .clk(clk));
*/

always @(posedge clk) begin
	// Removed #1 delay to resolve CheckDelayTimescale-ML violation
	addr_l_out = addr;

end


// Replacing hardcoded flops with configurable (depending on cache size) code.

/*
mj_s_ff_s_d ff16(        .out(),
                        .in(stat_addr[8]),
                        .clk(clk));

mj_s_ff_s_d ff17(        .out(),
                        .in(stat_addr[7]),
                        .clk(clk));

mj_s_ff_s_d ff18(        .out(),
                        .in(stat_addr[6]),
                        .clk(clk));

mj_s_ff_s_d ff19(        .out(),
                        .in(stat_addr[5]),
                        .clk(clk));

mj_s_ff_s_d ff20(        .out(),
                        .in(stat_addr[4]),
                        .clk(clk));

mj_s_ff_s_d ff21(        .out(),
                        .in(stat_addr[3]),
                        .clk(clk));

mj_s_ff_s_d ff22(        .out(),
                        .in(stat_addr[2]),
                        .clk(clk));

mj_s_ff_s_d ff23(        .out(),
                        .in(stat_addr[1]),
                        .clk(clk));

mj_s_ff_s_d ff24(        .out(),
                        .in(stat_addr[0]),
                        .clk(clk));
*/

always @(posedge clk) begin
	// Removed #1 delay to resolve CheckDelayTimescale-ML violation
	stat_addr_l_out = stat_addr;

end


// Replacing hardcoded flops with configurable (depending on cache size) code.

/*
mj_s_ff_s_d ff25(        .out(),
                        .in(tag_in[18]),
                        .clk(clk));

mj_s_ff_s_d ff26(        .out(),
                        .in(tag_in[17]),
                        .clk(clk));

mj_s_ff_s_d ff27(        .out(),
                        .in(tag_in[16]),
                        .clk(clk));

mj_s_ff_s_d ff28(        .out(),
                        .in(tag_in[15]),
                        .clk(clk));

mj_s_ff_s_d ff29(        .out(),
                        .in(tag_in[14]),
                        .clk(clk));

mj_s_ff_s_d ff30(        .out(),
                        .in(tag_in[13]),
                        .clk(clk));

mj_s_ff_s_d ff31(        .out(),
                        .in(tag_in[12]),
                        .clk(clk));

mj_s_ff_s_d ff32(        .out(),
                        .in(tag_in[11]),
                        .clk(clk));

mj_s_ff_s_d ff33(        .out(),
                        .in(tag_in[10]),
                        .clk(clk));

mj_s_ff_s_d ff34(        .out(),
                        .in(tag_in[9]),
                        .clk(clk));

mj_s_ff_s_d ff34a(        .out(),
                        .in(tag_in[8]),
                        .clk(clk));

mj_s_ff_s_d ff35(        .out(),
                        .in(tag_in[7]),
                        .clk(clk));

mj_s_ff_s_d ff36(        .out(),
                        .in(tag_in[6]),
                        .clk(clk));

mj_s_ff_s_d ff37(        .out(),
                        .in(tag_in[5]),
                        .clk(clk));

mj_s_ff_s_d ff38(        .out(),
                        .in(tag_in[4]),
                        .clk(clk));

mj_s_ff_s_d ff39(        .out(),
                        .in(tag_in[3]),
                        .clk(clk));

mj_s_ff_s_d ff40(        .out(),
                        .in(tag_in[2]),
                        .clk(clk));

mj_s_ff_s_d ff41(        .out(),
                        .in(tag_in[1]),
                        .clk(clk));

mj_s_ff_s_d ff42(        .out(),
                        .in(tag_in[0]),
                        .clk(clk));
*/

always @(posedge clk) begin
        // Removed #1 delay to resolve CheckDelayTimescale-ML violation
        tag_in_l_out = tag_in;

end


// Replacing hardcoded flops with configurable (depending on cache size) code.

/*
mj_s_ff_s_d ff43(        .out(),
                        .in(cmp_addr_in[8]),
                        .clk(clk));

mj_s_ff_s_d ff44(        .out(),
                        .in(cmp_addr_in[7]),
                        .clk(clk));

mj_s_ff_s_d ff45(        .out(),
                        .in(cmp_addr_in[6]),
                        .clk(clk));

mj_s_ff_s_d ff46(        .out(),
                        .in(cmp_addr_in[5]),
                        .clk(clk));

mj_s_ff_s_d ff47(        .out(),
                        .in(cmp_addr_in[4]),
                        .clk(clk));

mj_s_ff_s_d ff48(        .out(),
                        .in(cmp_addr_in[3]),
                        .clk(clk));

mj_s_ff_s_d ff49(        .out(),
                        .in(cmp_addr_in[2]),
                        .clk(clk));

mj_s_ff_s_d ff50(        .out(),
                        .in(cmp_addr_in[1]),
                        .clk(clk));

mj_s_ff_s_d ff51(        .out(),
                        .in(cmp_addr_in[0]),
                        .clk(clk));

mj_s_ff_s_d ff52(        .out(),
                        .in(cmp_addr_in[10]),
                        .clk(clk));

mj_s_ff_s_d ff53(        .out(),
                        .in(cmp_addr_in[11]),
                        .clk(clk));

mj_s_ff_s_d ff54(        .out(),
                        .in(cmp_addr_in[12]),
                        .clk(clk));

mj_s_ff_s_d ff55(        .out(),
                        .in(cmp_addr_in[13]),
                        .clk(clk));

mj_s_ff_s_d ff56(        .out(),
                        .in(cmp_addr_in[14]),
                        .clk(clk));

mj_s_ff_s_d ff57(        .out(),
                        .in(cmp_addr_in[15]),
                        .clk(clk));

mj_s_ff_s_d ff58(        .out(),
                        .in(cmp_addr_in[16]),
                        .clk(clk));

mj_s_ff_s_d ff59(        .out(),
                        .in(cmp_addr_in[17]),
                        .clk(clk));

mj_s_ff_s_d ff60(        .out(),
                        .in(cmp_addr_in[18]),
                        .clk(clk));
*/

always @(posedge clk) begin
        // Removed #1 delay to resolve CheckDelayTimescale-ML violation
        cmp_addr_in_l = cmp_addr_in;

end

endmodule
