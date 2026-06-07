module curve_synth_5064_20260111_091216_attempt7 (
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
  // This example uses a concurrent 'cover property' statement with a simple sequence,
  // which is a SystemVerilog Assertion (SVA) construct.
  // The property checks if 'in_data' is true, and in the next clock cycle, 'out_data' is true.
  cover property (@(posedge clk) in_data ##1 out_data);

endmodule
