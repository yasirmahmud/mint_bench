module functional_unit (
  input wire        enable_i,
  input wire  [1:0] data_i,
  output wire [1:0] data_o
);
  assign data_o[0] = enable_i ^ data_i[0];
  assign data_o[1] = enable_i ^ data_i[1];
endmodule
