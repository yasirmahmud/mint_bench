module curve_stx_ve_300_20260111_192749_066891_w7792_attempt8 ();

  // Declare a SystemVerilog constant logic variable.
  // Although the prompt specifies Verilog-2001, the "const" keyword is a SystemVerilog feature
  // targeted by the STX_VE_300 rule, as evidenced by the rule description and context examples.
  // To resolve STX_VE_300, 'CONFIG_VAL' must not be declared as 'const' if it is later reassigned.
  logic [3:0] CONFIG_VAL = 4'hA;

  // Define a task that attempts to modify the variable.
  task update_config_value();
    // This re-assignment is now legal since 'CONFIG_VAL' is no longer a 'const' variable.
    CONFIG_VAL = 4'hF;
  endtask

  // Use an initial block to call the task and execute the re-assignment.
  initial begin
    update_config_value();
  end

endmodule
