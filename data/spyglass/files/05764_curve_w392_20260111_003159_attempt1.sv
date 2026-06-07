module curve_w392_20260111_003159_attempt1 (
  input wire clk_i,
  input wire rst_i,
  input wire data_in_i,
  output reg q_ah_o,
  output reg q_al_o
);

// First usage of rst_i: Active High Asynchronous Reset
always @(posedge clk_i or posedge rst_i) begin
  if (rst_i) begin // This implies active-high reset for rst_i
    q_ah_o <= 1'b0;
  end else begin
    q_ah_o <= data_in_i;
  end
end

// Second usage of rst_i: Active Low Asynchronous Reset
always @(posedge clk_i or negedge rst_i) begin
  if (!rst_i) begin // This implies active-low reset for rst_i
    q_al_o <= 1'b0;
  end else begin
    q_al_o <= q_ah_o; // Use q_ah_o to avoid unused signal warnings
  end
end

endmodule
