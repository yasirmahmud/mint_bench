module mj_s_ff_s_d(out,in, clk);
output out;
input clk;
input in;

reg out;

/* synopsys translate_off */
initial out = 0;
/* synopsys translate_on */

always @(posedge clk)
            out <= #1 in;

endmodule
