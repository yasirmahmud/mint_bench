module curve_synth_5143_20260111_201639_145003_w37940_attempt10 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg data_out
);

  // Synthesizable logic: A simple D-flip-flop to ensure there's synthesizable content.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

  // SYNTH_5143: Initial block is ignored for synthesis.
  // This block explicitly triggers the target rule as initial blocks are
  // simulation-only constructs and are ignored by synthesis tools.
  initial begin
    $display("INFO: Initial simulation message after startup.");
  end

endmodule
