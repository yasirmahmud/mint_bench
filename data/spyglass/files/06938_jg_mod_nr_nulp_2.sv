module another_module (
  input wire a,
  , // This comma creates a null port
  input wire b,
  output wire c
);
  assign c = a & b;
endmodule
