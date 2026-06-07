module mj_s_ff_se_d(out,in, lenable, clk);
output out;
input clk;
input lenable;
input in;
reg out;
always @(posedge clk)
        if (lenable)
            out <= #1 in;
        else
            out <= #1 out;
endmodule
