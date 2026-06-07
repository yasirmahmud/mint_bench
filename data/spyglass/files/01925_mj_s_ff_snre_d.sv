module mj_s_ff_snre_d(out,in, lenable,reset_l, clk);
output out;
input clk;
input lenable;
input reset_l;
input in;

reg out;
always @(posedge clk)
        if (~reset_l) 
	out <= #1 1'b0;
	else
    	if (lenable)
            out <= #1 in;
        else
            out <= #1 out;

endmodule
