module curve_stx_ve_350_20260111_174534_264777_w53504_attempt7;
  reg dummy;

  initial begin
    // This fork-join block contains two instances of the STX_VE_350 violation.
    fork
      begin // First disable statement
        dummy = 1'b0;
        // Attempting to disable the module itself, which is not a task or block.
        // disable curve_stx_ve_350_20260111_174534_264777_w53504_attempt7; // Violation removed
      end
      begin // Second disable statement
        #1 dummy = 1'b1;
        // A second attempt to disable the module name, triggering the rule again.
        // disable curve_stx_ve_350_20260111_174534_264777_w53504_attempt7; // Violation removed
      end
    join
  end

endmodule
