module sparecaseexprbit_ml_ex1 (input sel, output reg out);
 always @(*) begin case (sel) 1'b0: out = 1'b0;
 endcase end endmodule
