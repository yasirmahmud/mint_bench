module high_past_count_example_2 (
  input logic clk,
  input logic enable_signal,
  output logic output_flag
);

  always_ff @(posedge clk) begin
    output_flag <= $past(enable_signal, 120); // Cycle count 120 > max_cycle_count 100
  end

endmodule
