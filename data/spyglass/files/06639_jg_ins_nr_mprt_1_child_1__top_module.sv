module top_module (
  input wire clk,
  input wire reset,
  input wire data_in,
  output wire data_out
);
  wire intermediate_signal;

  child_module u_child (
    .in_a(data_in),
    .out_b(intermediate_signal)
  );

  assign data_out = intermediate_signal;
endmodule
