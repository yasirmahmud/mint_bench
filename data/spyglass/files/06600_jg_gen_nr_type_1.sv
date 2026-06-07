module BadGenericTypeReal #(
  real REAL_PARAM = 3.14
)(
  input logic clk,
  input logic rst,
  output logic out_signal
);

  assign out_signal = (REAL_PARAM > 3.0) ? 1'b1 : 1'b0;

endmodule
