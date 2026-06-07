module detect_array_04;
  logic [7:0] large_array [0:100];
  assign large_array[0] = large_array[1];
  assign large_array[1] = large_array[0];
endmodule
