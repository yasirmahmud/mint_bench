module STX_VE_349_example();

  reg trigger_condition;
  reg some_output;

  // To resolve the STX_VE_349 violation "Task or function name ( exit ) not defined",
  // a user-defined task named 'exit' is provided.
  // This task calls the standard Verilog system task '$finish' to preserve
  // the original functional behavior, which is to terminate the simulation
  // when 'exit' is called, as implied by the design description.
  task exit;
    $finish;
  endtask

  // This initial block demonstrates a call to 'exit'.
  // According to the STX_VE_349 rule description and context examples,
  // SpyGlass flags 'exit' as an undefined task or function,
  // likely expecting a user-defined task with this name.
  initial begin
    trigger_condition = 1'b1; // Set condition to ensure 'exit' is called
    some_output = 1'b0;

    if (trigger_condition) begin
      // The call to 'exit' now invokes the user-defined task, resolving the violation.
      exit;
    end else begin
      some_output = 1'b1;
    end
  end

endmodule
