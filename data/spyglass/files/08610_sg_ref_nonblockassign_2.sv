module NonBlockAssign_ex2(out, in, clk);
 output out;
 input in, clk;
 reg out;
 always @(posedge clk) out = in;
 endmodule
