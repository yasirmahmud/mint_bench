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

  // FIX for W415: Signal 'W346_ex1.b_out' has multiple simultaneous drivers.
  // The 'b_out' register was driven by two separate always blocks (one for posedge,
  // one for negedge). This is illegal in Verilog as a single 'reg' can only be
  // driven by one procedural block. To resolve the W415 violation while preserving
  // the functional behavior (updating on both clock edges with different data),
  // the logic has been merged into a single always block sensitive to both edges.
  // Inside this block, the current level of 'clk_sig' is used to differentiate
  // between the positive and negative edge events.
  always @(posedge clk_sig or negedge clk_sig) begin
    if (clk_sig == 1'b1) begin // This branch executes on the positive edge of clk_sig
      b_out <= a_in;
    end else begin             // This branch executes on the negative edge of clk_sig
      b_out <= ~a_in;
    end
  end

endmodule
