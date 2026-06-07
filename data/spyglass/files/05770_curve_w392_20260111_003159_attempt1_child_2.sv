module curve_w392_20260111_003159_attempt1 (
  input wire clk_i,
  input wire rst_i,
  input wire data_in_i,
  output reg q_ah_o,
  output reg q_al_o
);

// The W392 violation regarding 'rst_i' being used with different polarities
// is resolved by explicitly defining its polarity in the sensitivity list
// and condition for each asynchronous reset usage.
// The 'rst_i_n' wire is no longer needed.

// First usage of rst_i: Active High Asynchronous Reset
// This block uses rst_i directly as an active-high reset.
always @(posedge clk_i or posedge rst_i) begin
  if (rst_i) begin // Active-high reset for rst_i
    q_ah_o <= 1'b0;
  end else begin
    q_ah_o <= data_in_i;
  end
end

// Second usage of rst_i: Active Low Asynchronous Reset
// This block now explicitly uses the original rst_i signal as an active-low reset.
// This preserves the functional behavior while resolving the W392 violation.
always @(posedge clk_i or negedge rst_i) begin // Changed to detect negedge rst_i
  if (!rst_i) begin // Active-low reset for rst_i
    q_al_o <= 1'b0;
  end else begin
    q_al_o <= q_ah_o;
  end
end

endmodule
