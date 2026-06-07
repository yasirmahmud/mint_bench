module mj_s_ff_snr_d(out,in, reset_l, clk);
output out;
input clk;
input reset_l;
input in;

reg out;

always @(posedge clk)
        if (~reset_l)
            out <= #1 1'b0;
        else
            out <= #1 in;

endmodule
