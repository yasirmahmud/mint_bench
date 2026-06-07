module IfWithoutElse_ex2(input wire in_cond, output reg out_data);
 always @* begin if (in_cond) out_data = 1'b1;
 end endmodule
