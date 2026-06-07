module ff_s_2 (out, din, clk) ;
    output  [1:0]  out;
    input   [1:0]  din;
    input           clk;

    ff_s    ff_s_0(out[0], din[0], clk);
    ff_s    ff_s_1(out[1], din[1], clk);

endmodule
