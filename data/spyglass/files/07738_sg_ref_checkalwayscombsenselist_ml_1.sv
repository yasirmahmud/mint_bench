module CheckAlwaysCombSenseList_ML_ex1 (input a, output reg b);
 always_comb begin if (b == 1'b0) b = a;
 else b = 1'b0;
 end endmodule
