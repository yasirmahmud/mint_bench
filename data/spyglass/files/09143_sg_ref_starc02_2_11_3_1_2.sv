module fsm_mixed_ex2 (input clk, input ares, input b);
 localparam N = 1'b0;
 reg a;
 always @(posedge clk or posedge ares) begin if (ares) a <= 1'b0;
 else if (a == N) a <= b;
 else a <= 1'b1;
 end endmodule
