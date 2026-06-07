module curve_stx_ve_350_20260110_143444_attempt2;
  reg dummy_reg;

  initial begin
    dummy_reg = 1'b0; // Assign value to avoid unused signal warning
    $display("Dummy reg value: %b", dummy_reg); // Read value to avoid unused signal warning

    // STX_VE_350 violation 1: Disabling the module name (not a task or block)
    disable curve_stx_ve_350_20260110_143444_attempt2;

    // STX_VE_350 violation 2: Disabling a reg variable (not a task or block)
    disable dummy_reg;
  end

endmodule
