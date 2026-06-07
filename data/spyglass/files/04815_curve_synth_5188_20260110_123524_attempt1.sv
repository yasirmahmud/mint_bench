module curve_synth_5188_20260110_123524_attempt1 (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0;
    end else begin
      data_out <= @(posedge clk) data_in; // SYNTH_5188 violation: Event control on RHS of assignment
    end
  end

endmodule
