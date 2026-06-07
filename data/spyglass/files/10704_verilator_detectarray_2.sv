module detect_array_02;
  logic [7:0] arr [0:1];
  assign arr[0] = arr[1];
  assign arr[1] = arr[0];
endmodule
