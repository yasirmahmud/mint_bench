module star_ex2_module (input wire a, output reg b);
 always @(*) begin if (a == 1'bx) begin b = 1;
 end else begin b = 0;
 end end endmodule
