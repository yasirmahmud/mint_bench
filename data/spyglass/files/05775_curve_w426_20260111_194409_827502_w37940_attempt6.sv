module curve_w426_20260111_194409_827502_w37940_attempt6 (
    input in_val,
    output reg output_reg
);

  // This task assigns to 'output_reg', which is declared at the module level,
  // making it a "global variable" from the task's perspective.
  task set_output_task;
    output_reg = in_val; // W426 violation triggered here
  endtask

  always @* begin
    set_output_task;
  end

endmodule
