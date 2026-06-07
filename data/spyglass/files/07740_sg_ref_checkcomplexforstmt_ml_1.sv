module CheckComplexForStmt_ML_ex1;
 reg [1023:0] temp_var;
 integer i, j, k, l;
 initial begin temp_var = 1024'h0;
 for (i = 0; i < 2; i = i + 1) begin for (j = 0; j < 2; j = j + 1) begin for (k = 0; k < 2; k = k + 1) begin for (l = 0; l < 2; l = l + 1) begin temp_var = temp_var + 1;
 if (temp_var[0]) begin end end end end end endmodule
