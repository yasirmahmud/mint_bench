module curve_w426_20260111_194409_827502_w37940_attempt7 (
    input clk,
    input rst,
    output reg output_reg
);

  // This task assigns to 'output_reg', which is declared at the module level.
  // This directly triggers the W426 violation: "Global variable 'output_reg' should not be 'set' in task".
  task set_output_task;
    output_reg <= 1'b0; // W426 violation occurs here
  endtask

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      output_reg <= 1'b0;
    end else begin
      set_output_task; // Call the task in the sequential block
    end
  end

endmodule
