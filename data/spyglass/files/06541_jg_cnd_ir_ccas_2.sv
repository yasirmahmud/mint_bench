module constant_ternary_condition (
  input wire a,
  input wire b,
  output wire y
);

  assign y = (1'b0) ? a : b; // Constant conditional expression

endmodule
