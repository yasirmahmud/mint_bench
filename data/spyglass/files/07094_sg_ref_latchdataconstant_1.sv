module latch_data_constant_ex1 (input en, output reg q);
 always @* if (en) q = 1'b1;
 endmodule
