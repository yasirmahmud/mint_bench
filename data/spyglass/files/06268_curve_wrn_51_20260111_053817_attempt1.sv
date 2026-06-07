module wrn_51_example (
  input [7:0] data_in,
  output [39:0] data_out
);

  assign data_out = {data_in, 1};

endmodule
