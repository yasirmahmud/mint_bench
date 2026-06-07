module if_without_else_ml_ex1 ( input wire cond, output reg out_q );
 always @* begin if (cond) out_q = 1'b1;
 end endmodule
