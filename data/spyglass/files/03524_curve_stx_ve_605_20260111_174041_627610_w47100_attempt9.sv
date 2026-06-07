module curve_stx_ve_605_20260111_174041_627610_w47100_attempt9 ();

  localparam LP_CONSTANT = 100; // Define a localparam

  task my_task;
  begin
    // STX_VE_605 violation: Attempting to assign a new value
    // to a localparam, which is a static constant and cannot
    // be modified after elaboration.
    LP_CONSTANT = 200; // Illegal assignment
  end
  endtask

  initial begin
    my_task(); // Call the task; the violation occurs at the assignment site
  end

endmodule
