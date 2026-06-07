module BadGenericTypeTime #(
  time TIME_PARAM = 10ns
)(
  input logic clk,
  input logic rst,
  output logic out_signal
);

  // This is just to use the parameter, not for actual timing simulation
  // A lint tool would flag the type of TIME_PARAM itself.
  assign out_signal = (TIME_PARAM == 10ns) ? 1'b1 : 1'b0;

endmodule
