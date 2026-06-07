module curve_stx_ve_300_20260111_192749_066891_w7792_attempt8 ();

  // Declare a SystemVerilog constant logic variable.
  // Although the prompt specifies Verilog-2001, the "const" keyword is a SystemVerilog feature
  // targeted by the STX_VE_300 rule, as evidenced by the rule description and context examples.
  const logic [3:0] CONFIG_VAL = 4'hA;

  // Define a task that attempts to modify the constant variable.
  task update_config_value();
    // This re-assignment to a 'const' variable is illegal and triggers STX_VE_300.
    CONFIG_VAL = 4'hF;
  endtask

  // Use an initial block to call the task and execute the illegal re-assignment.
  initial begin
    update_config_value();
  end

endmodule
