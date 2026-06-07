module mj_s_ff_se_d_8 (
    output [7:0] out,
    input  [7:0] din,
    input        lenable,
    input        clk,
    input        sin,
    input        sm,
    output       so
);
    mj_s_ff_se_d #(.WIDTH(8)) u_mj_s_ff_se_d (
        .out(out),
        .din(din),
        .lenable(lenable),
        .clk(clk),
        .sin(sin),
        .sm(sm),
        .so(so)
    );
endmodule
