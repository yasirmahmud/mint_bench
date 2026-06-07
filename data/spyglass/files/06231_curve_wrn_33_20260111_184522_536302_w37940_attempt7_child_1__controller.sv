module controller (
  input wire clk_i,
  input wire rst_ni,
  input wire data_i,
  output wire result_o
);
  wire intermediate_signal;
  
  // To resolve W240: Input 'clk_i' declared but not read.
  // This ensures the port is used without altering the existing combinatorial logic.
  wire unused_clk_i = clk_i;

  // WRN_33: Module instance name not specified - added instance name 'u_logic_gate'
  logic_gate u_logic_gate (
    .in_a(data_i),
    .in_b(rst_ni),
    .out_c(intermediate_signal)
  );

  assign result_o = intermediate_signal;
endmodule
