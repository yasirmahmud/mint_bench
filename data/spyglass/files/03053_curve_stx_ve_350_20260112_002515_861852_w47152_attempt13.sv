module curve_stx_ve_350_20260112_002515_861852_w47152_attempt13 (
  output reg dummy_out
);

  // An initial block to trigger the violations and manage dummy output activity.
  initial begin
    // Initialize dummy_out to prevent 'X' propagation and ensure activity.
    dummy_out = 1'b0;

    // First instance of STX_VE_350 violation:
    // Attempting to 'disable' the module name itself, which is not a task, function, or named block.
    disable curve_stx_ve_350_20260112_002515_861852_w47152_attempt13; // VIOLATION 1

    // Introduce a distinct activity and a small delay to separate the violations
    // and ensure the output remains active.
    #5;
    dummy_out = 1'b1;

    // Second instance of STX_VE_350 violation:
    // Another attempt to 'disable' the module name, ensuring two FATAL violations are reported.
    disable curve_stx_ve_350_20260112_002515_861852_w47152_attempt13; // VIOLATION 2

    // Final state for dummy_out to ensure it is always driven.
    #5;
    dummy_out = 1'b0;
  end

endmodule
