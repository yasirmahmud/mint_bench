module multiple_drivers_ex2 (input a, input b, output reg out_reg);
 always @(a) begin out_reg = a;
 end always @(b) begin out_reg = b;
 end endmodule
