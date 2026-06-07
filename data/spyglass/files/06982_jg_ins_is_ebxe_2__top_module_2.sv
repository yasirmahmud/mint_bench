module top_module_2 (
  input logic clk_i,
  input logic data_i,
  output logic data_o
);
  another_leaf instance_of_leaf (
    .x(data_i),
    .y(data_o)
  );
endmodule
