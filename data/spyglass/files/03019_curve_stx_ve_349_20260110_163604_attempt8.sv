module curve_stx_ve_349_20260110_163604_attempt8 (
  input wire a,
  output wire b
);

  // To avoid unused signal warnings
  assign b = a;

  // Define a user-defined task
  task my_dummy_task;
    begin
      // Calling an undefined task 'exit' within a user-defined task.
      // This is expected to trigger STX_VE_349.
      exit; // STX_VE_349: Task or function name ( exit ) not defined
    end
  endtask

  initial begin
    // Call the user-defined task to ensure the 'exit' statement is encountered.
    my_dummy_task;
  end

endmodule
