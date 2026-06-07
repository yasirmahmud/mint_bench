module multiassign_ex1 (input clk, input a, output reg q);
 always @(posedge clk) begin q = a;
 q = ~a;
 end endmodule
