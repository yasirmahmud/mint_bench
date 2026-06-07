module ff_s_16 (out, din, clk) ;
    output  [15:0]  out;
    input   [15:0]  din;
    input           clk;

    ff_s    ff_s_0(out[0], din[0], clk);
    ff_s    ff_s_1(out[1], din[1], clk);
    ff_s    ff_s_2(out[2], din[2], clk);
    ff_s    ff_s_3(out[3], din[3], clk);
    ff_s    ff_s_4(out[4], din[4], clk);
    ff_s    ff_s_5(out[5], din[5], clk);
    ff_s    ff_s_6(out[6], din[6], clk);
    ff_s    ff_s_7(out[7], din[7], clk);
    ff_s    ff_s_8(out[8], din[8], clk);
    ff_s    ff_s_9(out[9], din[9], clk);
    ff_s    ff_s_10(out[10], din[10], clk);
    ff_s    ff_s_11(out[11], din[11], clk);
    ff_s    ff_s_12(out[12], din[12], clk);
    ff_s    ff_s_13(out[13], din[13], clk);
    ff_s    ff_s_14(out[14], din[14], clk);
    ff_s    ff_s_15(out[15], din[15], clk);

endmodule
