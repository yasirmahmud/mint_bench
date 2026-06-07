module my_module #(
  parameter WIDTH = 32
) (
  input dummy_in,
  output [WIDTH-1:0] dummy_out
);
  // Minimal logic to use WIDTH, as actual functionality was not specified
  assign dummy_out = {WIDTH{1'b0}};
endmodule
