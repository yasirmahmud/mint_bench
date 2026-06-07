module W496a_ex1 (input wire a, output reg out);
 always @(*) begin if (a == 1'bz) begin out = 1;
 end else begin out = 0;
 end end endmodule
