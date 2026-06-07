module curve_synth_12611_20260111_224215_977492_w15680_attempt12 (
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
  // This property uses a complex, non-synthesizable clocking event involving
  // the posedge of 'clk' OR a transition on 'data_in' treated as a clock,
  // making it distinct from previous double-edge or multi-bit clock examples.
  // Although 'data_in' is not typically a clock, SVA allows it for clocking events,
  // but synthesis tools will ignore such property blocks.
  property p_mixed_edge_clock;
    @(posedge clk or posedge data_in) (data_out == data_in);
  endproperty

endmodule
