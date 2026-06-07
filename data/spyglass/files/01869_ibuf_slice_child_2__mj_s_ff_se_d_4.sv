module mj_s_ff_se_d_4 (
    output [3:0] out,
    input  [3:0] din,
    input        lenable,
    input        clk,
    input        sin,
    input        sm,
    output       so
);
    mj_s_ff_se_d #(.WIDTH(4)) u_mj_s_ff_se_d (
        .out(out),
        .din(din),
        .lenable(lenable),
        .clk(clk),
        .sin(sin),
        .sm(sm),
        .so(so)
    );
endmodule
