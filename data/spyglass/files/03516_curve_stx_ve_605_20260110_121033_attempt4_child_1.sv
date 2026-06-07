module curve_stx_ve_605_20260110_121033_attempt4 ();

  // Declare a localparam with an initial value
  localparam MY_LOCAL_CONSTANT = 10;

  // Attempt to reassign the localparam within a task
  task my_modify_task;
    begin
      // FATAL: Illegal attempt to assign to a localparam (STX_VE_605 violation)
      // localparams are compile-time constants and cannot be reassigned.
      // The illegal assignment has been removed to fix the violation.
    end
  endtask

  // Dummy signal to ensure MY_LOCAL_CONSTANT is used and avoid unused signal warnings
  reg [7:0] output_val;
  always @(*) begin
    output_val = MY_LOCAL_CONSTANT + 5;
  end

endmodule
