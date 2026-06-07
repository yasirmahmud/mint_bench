module curve_synth_5317_20260111_215047_011528_w38092_attempt14 (
  input wire clk,
  input wire enable_signal,
  input wire [3:0] in_val,
  output reg [3:0] out_val
);

  // SYNTH_5317 violation: This always block has an event control
  // in its sensitivity list (`enable_signal`), and an assignment
  // within it includes an embedded event control (`@(posedge clk)`) in the RHS.
  // This construct is not supported by synthesis.
  always @(enable_signal) begin
    out_val = @(posedge clk) in_val;
  end

endmodule
