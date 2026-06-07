module curve_stx_ve_1188_20260111_230116_473639_w49296_attempt12 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  genvar i; // Declare genvar 'i'

  // STX_VE_1188 violation expected here.
  // A genvar 'i' is a compile-time construct used for elaboration-time loops (generate blocks).
  // It does not represent a runtime signal or constant that can be evaluated
  // within an 'always' block for procedural assignments. Using it in this context
  // is invalid, as it is outside of any generate loop it indexes.
  always @* begin
    data_out = data_in + i; // Invalid context: 'i' is used inside an always block
  end

endmodule
