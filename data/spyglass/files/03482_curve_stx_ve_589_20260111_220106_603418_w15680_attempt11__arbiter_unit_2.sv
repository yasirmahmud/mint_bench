// This re-declaration of the module 'arbiter_unit' triggers STX_VE_589.
module arbiter_unit (
  input wire request_signal,
  output wire busy_signal
);

  assign busy_signal = request_signal;

endmodule
