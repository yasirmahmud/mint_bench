module curve_stx_ve_349_20260110_163604_attempt7 (
  input wire a,
  output wire b
);

  // Assign 'b' based on 'a' to avoid unused signal warnings
  assign b = a;

  initial begin
    // Calling an undefined task 'exit' directly in an initial block.
    // This should trigger STX_VE_349.
    exit; // STX_VE_349: Task or function name ( exit ) not defined
  end

endmodule
