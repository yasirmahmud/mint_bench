module controller (
  input wire clk_i,
  input wire rst_ni,
  input wire data_i,
  output wire result_o
);
  wire intermediate_signal;

  // WRN_33: Module instance name not specified
  logic_gate (
    .in_a(data_i),
    .in_b(rst_ni),
    .out_c(intermediate_signal)
  );

  assign result_o = intermediate_signal;
endmodule
