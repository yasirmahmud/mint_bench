module module_ex1;
 reg out;
 always @(*) begin case (1) 1'b1: out = 1'b0;
 default: out = 1'b1;
 endcase end endmodule
