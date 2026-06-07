module tristate_if_ex2(input en, input d_in, inout tri_sig, output reg out_val);
 assign tri_sig = en ? d_in : 1'bz;
 always @(*) begin if (tri_sig) out_val = 1'b1;
 else out_val = 1'b0;
 end endmodule
