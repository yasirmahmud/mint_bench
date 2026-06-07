module sub_module (
  input wire dummy_in,
  output wire dummy_out
);
  // Declare 'P' as a string parameter. Default assignment is a string literal.
  parameter string P = "default_string";

  // Minimal logic to prevent 'empty definition' or 'unused port' warnings
  assign dummy_out = dummy_in;
endmodule
