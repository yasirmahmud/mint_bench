module top_module (
  input wire sys_clk,
  output wire sys_out
);
  // Violation: Instantiation without an instance name
  child_module (
    .clk(sys_clk),
    .out_signal(sys_out)
  );
endmodule
