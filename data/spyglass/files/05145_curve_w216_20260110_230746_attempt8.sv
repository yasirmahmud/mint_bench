module curve_w216_20260110_230746_attempt8 (
  input wire [31:0] input_val,
  output wire [7:0] byte_out
);

  // Declare an integer variable. SpyGlass typically treats 'integer' as 32-bit.
  integer internal_int;

  // Assign the integer variable from an input. This ensures 'internal_int' is used.
  assign internal_int = input_val;

  // This line is specifically designed to trigger SpyGlass W216.
  // W216 flags "Inappropriate range select for int_part_sel variable".
  // SpyGlass considers selecting a range like [7:0] from an 'integer'
  // (which would implicitly be 32-bit) and assigning it to a smaller-width
  // register/wire as redundant or potentially confusing.
  // A direct assignment `byte_out = internal_int;` would achieve the same
  // implicit truncation to 8 bits for the lower bits, making the explicit
  // range selection `[7:0]` unnecessary from SpyGlass's perspective.
  assign byte_out = internal_int[7:0];

endmodule
