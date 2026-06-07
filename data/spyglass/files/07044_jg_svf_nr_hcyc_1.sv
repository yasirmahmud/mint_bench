module high_past_count_example_1 (
  input logic clk,
  input logic data_in
);

  always_ff @(posedge clk) begin
    if ($past(data_in, 101)) begin // Cycle count 101 > max_cycle_count 100
      // Some logic dependent on past value
    end
  end

endmodule
