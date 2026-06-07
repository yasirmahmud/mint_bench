module STX_VE_349_example();

  reg trigger_condition;
  reg some_output;

  // This initial block demonstrates a call to 'exit'.
  // According to the STX_VE_349 rule description and context examples,
  // SpyGlass flags 'exit' as an undefined task or function,
  // likely expecting a user-defined task with this name.
  initial begin
    trigger_condition = 1'b1; // Set condition to ensure 'exit' is called
    some_output = 1'b0;

    if (trigger_condition) begin
      // STX_VE_349 violation: Task or function name ( exit ) not defined
      exit;
    end else begin
      some_output = 1'b1;
    end
  end

endmodule
