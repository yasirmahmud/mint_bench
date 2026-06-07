module detect_array_16;
  logic [7:0] matrix [0:1][0:1];
  assign matrix[0][0] = matrix[0][1];
  assign matrix[0][1] = matrix[0][0];
endmodule
