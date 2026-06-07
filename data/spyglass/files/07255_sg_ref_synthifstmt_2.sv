module SynthIfStmt_ex2 (input a, output reg out);
 always @* if (a) out = 1;
 else ;
 endmodule
