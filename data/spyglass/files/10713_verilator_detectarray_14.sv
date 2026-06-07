module detect_array_14;
  logic [7:0] arr_a [0:1], arr_b [0:1];
  assign arr_a[0] = arr_b[0];
  assign arr_b[0] = arr_a[0];
endmodule
