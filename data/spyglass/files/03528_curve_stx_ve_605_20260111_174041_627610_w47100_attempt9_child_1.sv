module curve_stx_ve_605_20260111_174041_627610_w47100_attempt9 ();

  localparam LP_CONSTANT = 100; // Define a localparam

  task my_task;
  begin
    // STX_VE_605 violation resolved: Removed the illegal assignment to LP_CONSTANT.
    // Localparams are static constants and cannot be modified after elaboration.
    // The functional behavior is preserved as LP_CONSTANT always remains 100.
  end
  endtask

  initial begin
    my_task(); // Call the task
  end

endmodule
