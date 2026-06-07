module top11;
  `define BUILD_ID 1234
  logic [15:0] id_reg;
  assign id_reg = `BUILD_ID;
endmodule
