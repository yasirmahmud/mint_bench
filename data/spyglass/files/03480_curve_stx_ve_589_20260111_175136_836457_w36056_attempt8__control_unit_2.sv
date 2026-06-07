module control_unit (
  input wire reset,
  output wire busy
);
  assign busy = reset;
endmodule
