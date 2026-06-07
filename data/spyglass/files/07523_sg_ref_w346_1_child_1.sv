module W346_ex1 (
  input clk_sig,
  input a_in,
  output reg b_out
);

  // The original task 'my_task_ex1' contained event control statements (
  // @(posedge clk_sig) and @(negedge clk_sig)) which are not synthesizable
  // and trigger SYNTH_196 violations. To preserve the functional behavior
  // of 'b = a' at posedge and 'b = ~a' at negedge, this sequential logic
  // has been moved to dedicated 'always' blocks within the module.
  // 'clk_sig' was changed from 'reg' to 'input' to resolve the W123 violation
  // (variable read but never set), as it acts as a clock input to the design.
  // 'a_in' and 'b_out' serve as the module-level equivalents for the task's
  // input 'a' and output 'b', respectively.

  always @(posedge clk_sig) begin
    b_out <= a_in;
  end

  always @(negedge clk_sig) begin
    b_out <= ~a_in;
  end

endmodule
