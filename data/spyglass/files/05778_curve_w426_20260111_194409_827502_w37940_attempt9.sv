module curve_w426_20260111_194409_827502_w37940_attempt9 (
    input clk,
    input rst,
    output reg out_signal
);

  // This task directly sets the module-level output 'out_signal'.
  // This is the direct cause of the W426 violation.
  task reset_output;
    out_signal = 1'b0; // W426: Global variable 'out_signal' should not be 'set' in task
  endtask

  // Call the task from a sequential always block.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      reset_output; // Call task to reset out_signal
    end else begin
      out_signal <= 1'b1; // Assign a value directly in the else branch
    end
  end

endmodule
