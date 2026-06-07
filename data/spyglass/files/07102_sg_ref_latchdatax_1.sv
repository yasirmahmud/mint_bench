module latch_data_x_ex1 (input en, output reg q);
 wire d_val;
 assign d_val = 1'bx;
 always @* begin if (en) begin q = d_val;
 end end endmodule
