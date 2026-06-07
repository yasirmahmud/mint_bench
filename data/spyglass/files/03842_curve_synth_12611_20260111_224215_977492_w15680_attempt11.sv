module curve_synth_12611_20260111_224215_977492_w15680_attempt11 (
  input clk,
  input reset_n,
  input data_in,
  output reg data_out
);

  // A simple synthesizable flip-flop to use inputs and outputs
  // and avoid other linting warnings.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

  // SYNTH_12611 violation: Property blocks are ignored for synthesis.
  // This property explicitly uses a double-edge clocking event, which is non-synthesizable.
  property p_double_edge_stable_data;
    @(posedge clk or negedge clk) (data_in == $past(data_in));
  endproperty

endmodule
