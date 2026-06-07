module another_unused_module #(
  // This module is defined but not instantiated anywhere in 'main_design' or its sub-modules.
  parameter WIDTH = 8
) (
  input [WIDTH-1:0] data_in,
  output [WIDTH-1:0] data_out
);

  assign data_out = data_in;
endmodule
