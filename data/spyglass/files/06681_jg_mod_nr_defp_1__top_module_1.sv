module top_module_1 (
  input wire clk,
  output wire [7:0] result
);
  sub_module_a instance_a (
    .clk(clk),
    .data_out(result)
  );

  defparam instance_a.WIDTH = 16; // This will trigger the warning

endmodule
