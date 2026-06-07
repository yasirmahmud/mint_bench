module my_design (
  input clk, // Violates assumed input_pattern="i_.*"
  input i_reset,
  output o_valid
);

  assign o_valid = i_reset;

endmodule
