module top_module (
  input wire sys_clk,
  output wire sys_out
);
  wire internal_signal;

  // WRN_33: Module instance name not specified
  child_module (
    .clk(sys_clk),
    .out_signal(internal_signal)
  );

  assign sys_out = internal_signal;

endmodule
