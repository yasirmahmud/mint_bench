module test15;
  logic [15:0] word_data;
  logic [7:0] byte_0, byte_1;
  assign byte_0 = word_data[0 +: 8];
  assign byte_1 = word_data[8 +: 8];
endmodule
