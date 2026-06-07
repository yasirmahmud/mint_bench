module latch_data_x_ex2 (input wire clk, input wire en, output reg q);
 wire x_val;
 always @* if (en) q = x_val;
 endmodule
