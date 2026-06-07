module curve_stx_ve_605_20260111_174041_627610_w47100_attempt7 ();

  parameter MY_PARAM = 5;

  task update_param;
    begin
      // Parameters are compile-time constants and cannot be assigned new values procedurally.
      // The illegal assignment has been removed to resolve STX_VE_605.
    end
  endtask

  initial begin
    // Call the task.
    update_param;
  end

endmodule
