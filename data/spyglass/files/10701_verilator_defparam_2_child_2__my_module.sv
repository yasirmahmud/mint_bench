module my_module #(
  parameter WIDTH = 32
) (
  input dummy_in,
  output [WIDTH-1:0] dummy_out
);
  // Resolve W240: Input 'dummy_in' declared but not read.
  // This reads dummy_in without altering the functional behavior of dummy_out.
  wire _unused_dummy_in_ = dummy_in;

  // Minimal logic to use WIDTH, as actual functionality was not specified
  assign dummy_out = {WIDTH{1'b0}};
endmodule
