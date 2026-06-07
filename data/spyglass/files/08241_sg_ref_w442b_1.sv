module w442b_ex1 (input clk, input rst, input another_signal, output reg q);
 always @ (posedge clk or posedge rst) begin if (rst == another_signal) begin q <= 1'b0;
 end else begin q <= ~q;
 end end endmodule
