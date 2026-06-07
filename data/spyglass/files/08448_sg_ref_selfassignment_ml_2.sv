module self_assign_ex2 (input wire in_a, output reg out_b);
 always @* begin out_b = out_b;
 end endmodule
