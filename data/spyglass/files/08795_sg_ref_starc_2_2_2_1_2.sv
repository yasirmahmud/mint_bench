module my_module_ex2 (input a, input b, output reg out);
 always @(a) begin if (a) begin out = b;
 end else begin out = 1'b0;
 end end endmodule
