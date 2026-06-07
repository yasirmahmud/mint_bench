module example_15 (
  input a,
  output y
);
  // Removed "reg y;" to resolve WRN_68: Multiple declarations for port 'y'.
  // In ANSI port declarations, 'output y' implicitly declares 'y' as a wire or reg
  // depending on how it's driven. For an always_comb block, it implies a 'reg' type.
  reg status_bit;
  reg temp_status_bit;

  always @(*) begin
    // To preserve the original behavior (y gets the value of status_bit before it is updated)
    // and resolve the ALWCOMBORDER issue, a temporary variable is used.
    // y will now consistently reflect the value of 'a' from the previous combinational evaluation.
    temp_status_bit = status_bit;
    status_bit = a;
    y = temp_status_bit;
  end
endmodule
