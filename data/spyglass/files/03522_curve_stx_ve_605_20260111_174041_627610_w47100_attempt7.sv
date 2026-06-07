module curve_stx_ve_605_20260111_174041_627610_w47100_attempt7 ();

  parameter MY_PARAM = 5;

  task update_param;
    begin
      // Illegal attempt to assign a new value to a parameter in a procedural block.
      MY_PARAM = 10; // STX_VE_605 violation here
    end
  endtask

  initial begin
    // Call the task, though the violation occurs during parsing of the task definition itself.
    update_param;
  end

endmodule
