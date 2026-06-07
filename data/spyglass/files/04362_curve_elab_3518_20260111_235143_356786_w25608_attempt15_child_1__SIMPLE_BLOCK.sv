module SIMPLE_BLOCK (
  parameter integer INITIAL_VALUE = 10,
  input wire [7:0] in_val,
  output wire [7:0] out_val
);
  assign out_val = in_val + INITIAL_VALUE; // Simple combinational logic
endmodule
