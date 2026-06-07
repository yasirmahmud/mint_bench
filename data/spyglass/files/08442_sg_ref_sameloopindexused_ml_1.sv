module same_loop_index_ex1(output reg out1, output reg out2);
 reg k;
 always @* begin out1 = 1'b0;
 for (k = 0; k < 2; k = k + 1) out1 = out1 | (k == 1);
 end always @* begin out2 = 1'b0;
 for (k = 0; k < 3; k = k + 1) out2 = out2 | (k == 2);
 end endmodule
