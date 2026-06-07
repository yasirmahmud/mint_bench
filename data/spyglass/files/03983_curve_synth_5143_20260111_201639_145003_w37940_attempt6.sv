module curve_synth_5143_20260111_201639_145003_w37940_attempt6 (
  input wire clk,
  input wire rst_n,
  output reg output_val
);

  // Synthesizable logic to ensure ports are used and output is driven
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      output_val <= 1'b0;
    end else begin
      output_val <= ~output_val;
    end
  end

  // SYNTH_5143: Initial block is ignored for synthesis
  // This block explicitly triggers the target rule.
  initial begin
    // Using a simulation-only construct ($display) ensures this initial block
    // does not introduce any synthesis-related issues (like undriven nets,
    // unused signals, latches, or multiple drivers) when it is ignored.
    $display("Module %m initialized at time %t", $time);
  end

endmodule
