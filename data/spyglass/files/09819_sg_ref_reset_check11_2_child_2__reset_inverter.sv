// New module to explicitly invert the reset signal and potentially break linter tracing.
module reset_inverter (
  input  in_rst,
  output out_rst_n
);
  assign out_rst_n = !in_rst;
endmodule
