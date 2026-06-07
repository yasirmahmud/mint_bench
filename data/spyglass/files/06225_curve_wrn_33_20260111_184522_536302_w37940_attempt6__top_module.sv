module top_module (
  input wire sys_clk,
  output wire sys_out
);
  wire data_path_signal;

  // WRN_33: Module instance name not specified
  sub_module (
    .in_a(sys_clk),
    .out_b(data_path_signal)
  );

  assign sys_out = data_path_signal;
endmodule
