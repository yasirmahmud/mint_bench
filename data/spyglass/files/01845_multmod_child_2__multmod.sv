module multmod (
    multout,
    nx_multfunc_rom0,
    nx_multfunc_rom1,
    romsel,
    nx_cyc0_rdy,
    movf,
    ma1,
    ma0,
    mb1,
    mb0,
    sm,
    sin,
    so,
    clk,
    reset_l,
    fpuhold
);
    output [31:0] multout;
    output movf;
    output so; // Moved 'so' output declaration to be with other outputs

    input  [31:0] ma1;
    input  [3:0] nx_multfunc_rom0, nx_multfunc_rom1;
    input  [1:0] romsel;
    input  nx_cyc0_rdy;
    input  [20:0] ma0;
    input  [31:0] mb1;
    input  [20:0] mb0;
    input  (* unused *) sm; // Attribute moved from module header to port declaration
    input  (* unused *) sin; // Attribute moved from module header to port declaration
    input  clk;
    input  reset_l;
    input  fpuhold;

    wire [17:0]   nx_multdec_muxcntl;


multmod_dp p_multmod_dp (
    .mb1(mb1),
    .mb0(mb0),
    .ma1(ma1),
    .ma0(ma0),
    .clk(clk),
    .reset_l(reset_l),
    .nx_multdec_muxcntl(nx_multdec_muxcntl),
    .multout(multout),
    .movf(movf),
    .fpuhold(fpuhold),
    .so(),
    .sm(),
    .sin()
);


multmod_cntl p_multmod_cntl (
    .nx_multfunc_rom0(nx_multfunc_rom0),
    .nx_multfunc_rom1(nx_multfunc_rom1),
    .romsel(romsel),
    .nx_cyc0_rdy(nx_cyc0_rdy),
    .clk(clk),
    .reset_l(reset_l),
    .nx_multdec_muxcntl(nx_multdec_muxcntl)
);
endmodule
