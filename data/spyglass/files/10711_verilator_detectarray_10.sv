module detect_array_10;
  logic [7:0] a, b;
  logic [7:0] arr [0:1];
  assign arr[0] = a;
  assign b = arr[0];
  assign a = b;
endmodule
