module curve_synth_5064_20260111_091216_attempt6 (
  input clk,
  input rst_n,
  input in_data,
  output reg out_data
);

  // Minimal synthesizable logic: a simple D-flipflop with reset
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_data <= 1'b0;
    end else begin
      out_data <= in_data;
    end
  end

  // SYNTH_5064: COVER statements are not synthesizable. Ignoring for synthesis
  // This example uses a concurrent 'cover property' statement, which is a SystemVerilog Assertion (SVA) construct.
  // It is placed concurrently within the module body, which is the standard placement for SVA.
  // The rule description targets "COVER statements", and this is a form of such a statement.
  // Context examples for SYNTH_5064 show usage of 'assert property', suggesting that SVA constructs are parsed
  // for this rule without generating syntax errors related to SystemVerilog versioning (unlike immediate 'cover' in previous attempt).
  cover property (@(posedge clk) in_data == 1'b1);

endmodule
