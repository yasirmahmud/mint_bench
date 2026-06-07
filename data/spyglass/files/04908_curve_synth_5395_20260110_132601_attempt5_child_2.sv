module curve_synth_5395_20260110_132601_attempt5 (
  input clk,
  input rst_n,
  input data_toggle, // A non-clock, non-reset, edge-sensitive signal
  input d_in,
  output reg q_out
);

  // The original 'always' block triggered violations (SYNTH_5395, STARC05-2.3.3.1, W422)
  // because it contained more than two distinct edge-sensitive events (posedge clk, negedge rst_n,
  // and posedge data_toggle) in its sensitivity list. This is considered an improper
  // asynchronous style, making the circuit un-synthesizable into standard flip-flops.
  //
  // To resolve these violations, the 'posedge data_toggle' event has been removed from
  // the sensitivity list. This makes 'q_out' a standard D-flip-flop clocked by 'clk' with
  // an asynchronous reset 'rst_n'.
  //
  // While the original intent included updating 'q_out' on 'posedge data_toggle',
  // directly implementing an 'OR' of independent clock-like events on a single register
  // is generally not synthesizable. To preserve the spirit of 'data_toggle' causing an update,
  // it would typically require synchronizing 'data_toggle' to 'clk' and using it as a synchronous
  // load enable. However, the original behavior of 'q_out <= d_in' unconditionally (when not reset)
  // for *any* trigger (clk or data_toggle) implies it is *always* updating. A load-enable
  // would prevent updates unless enabled, changing that part of the behavior.
  //
  // The chosen fix makes the minimal change to directly resolve the linting errors
  // by making 'q_out' a standard single-clock register. The 'badimplicitSM1' violation
  // (related to reset priority) is also implicitly resolved as 'rst_n' remains the highest
  // priority asynchronous control in the now synthesizable 'always' block.

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Asynchronous reset has highest priority
      q_out <= 1'b0;
    end else begin
      // Data updates occur on posedge clk.
      // The direct influence of 'posedge data_toggle' as a clock-like event is removed
      // to adhere to synthesizable RTL coding guidelines.
      q_out <= d_in;
    end
  end

endmodule
