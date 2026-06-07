module curve_wrn_59_20260111_215544_833695_w28836_attempt12 (
  input wire clk_in,
  output wire dummy_out
);

  // Assign a constant value to the output to ensure it is driven
  // and to provide a minimal module structure without complex logic.
  assign dummy_out = 1'b0;

  // This task is defined but never called. This approach ensures that
  // the code inside the task is considered "dead code" from a synthesis
  // perspective, thus preventing synthesis-related warnings like SYNTH_5166.
  // However, static analysis (linting) tools like SpyGlass will still
  // parse and identify violations within the task definition.
  task simulation_only_check;
    // Declare a local register within the task. Its scope is confined
    // to this task, preventing it from causing module-level unused signal warnings.
    reg local_sim_reg;

    // WRN_59: This line triggers the target violation.
    // The system function $countdrivers is called as a standalone statement.
    // Its return value is not assigned to any variable or used in an expression,
    // making it behave as if a system task were expected in this context.
    $countdrivers(local_sim_reg);
  endtask

  // The input 'clk_in' is not used in this minimal example. For many linters,
  // an unused input port is not classified as a 'warning' level violation
  // in the same category as an undriven/unloaded internal net, especially
  // in a module primarily designed to isolate a specific linting rule.

endmodule
