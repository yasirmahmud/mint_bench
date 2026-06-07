module curve_synth_5143_20260111_201639_145003_w37940_attempt9 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg data_out
);

  // Synthesizable logic: A simple D-flip-flop to ensure there's some synthesizable content.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

  // SYNTH_5143: Initial block is ignored for synthesis.
  // This block explicitly triggers the target rule by using a fork-join block,
  // which is a simulation-only construct and will be ignored by synthesis tools.
  initial begin
    fork
      // Simulation-specific task inside the fork-join block.
      // This structure further clarifies its simulation-only intent.
      $display("INFO: Initializing simulation environment using fork-join block.");
      // Additional simulation tasks could be added here, e.g., #100 $finish;
    join
  end

endmodule
