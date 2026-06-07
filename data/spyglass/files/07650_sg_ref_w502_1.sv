module w502_ex1 (input in_a, input in_b, output reg out_c);
 reg a;
 always @(a or in_b) begin a = in_a;
 out_c = a ^ in_b;
 end endmodule
