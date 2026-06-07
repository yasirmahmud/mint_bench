module data_processor (
  input wire reset,
  output wire busy
);
  assign busy = reset;
endmodule
