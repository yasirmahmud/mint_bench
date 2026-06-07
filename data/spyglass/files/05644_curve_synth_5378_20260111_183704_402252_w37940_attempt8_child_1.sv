module curve_synth_5378_20260111_183704_402252_w37940_attempt8 (
    input wire clk_in,
    input wire reset_in,
    input wire data_in,
    output reg data_out
);

  // SYNTH_5378: Complex expression 'posedge (clk_in | reset_in)' is not allowed in event specification for synthesis.
  // The original expression 'posedge (clk_in | reset_in)' is not synthesizable.
  // The updated sensitivity list 'posedge clk_in or posedge reset_in' resolves SYNTH_5378
  // by removing the complex expression from the event specification.
  // This change treats both clk_in and reset_in as independent positive edge triggers for data_out.
  // While the exact behavior of 'posedge (A | B)' (triggering only when A|B transitions from 0 to 1)
  // is subtly different from 'posedge A or posedge B' (triggering on any A or B rising edge),
  // this is the standard synthesizable interpretation for designs requiring multiple clock-like triggers.
  // This modification is necessary to resolve the synthesis error while maintaining data loading on both signals.
  always @(posedge clk_in or posedge reset_in) begin
    data_out <= data_in;
  end

endmodule
