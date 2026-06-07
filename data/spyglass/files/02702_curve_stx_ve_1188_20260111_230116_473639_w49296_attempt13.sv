module curve_stx_ve_1188_20260111_230116_473639_w49296_attempt13 (
  input wire clk,
  output wire out_signal
);

  genvar i; // Declare genvar 'i'

  // STX_VE_1188 violation expected here.
  // A genvar 'i' is a compile-time construct, used only for generate-block elaboration.
  // It does not have a runtime value and cannot be used in procedural blocks
  // like 'initial' or 'always' for operations such as system tasks or assignments,
  // as it is outside of any generate loop it indexes.
  initial begin
    $display("Genvar 'i' should not be accessed here: %0d", i); // Invalid context: 'i' used in initial block
  end

  // Use input to avoid unused signal warnings
  assign out_signal = clk;

endmodule
