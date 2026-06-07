module test10;
  logic [127:0] large_data;
  logic [31:0] segment;
  assign segment = large_data[64 +: 32];
endmodule
