module w496b_ex2 (input [1:0] in_sig, output reg out_sig);
 always @(*) begin case (in_sig) 2'b00: out_sig = 1'b0;
 2'bz: out_sig = 1'b1;
 default: out_sig = 1'b0;
 endcase end endmodule
