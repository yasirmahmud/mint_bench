module curve_w392_20260111_003159_attempt2 (
  input wire clk_i,
  input wire rst_n_i,
  input wire data_i,
  output reg q_ah_o,
  output reg q_al_o
);

// First usage of rst_n_i: Interpreted as Active High Asynchronous Reset
always @(posedge clk_i or posedge rst_n_i) begin
  if (rst_n_i) begin // This condition implies active-high reset
    q_ah_o <= 1'b0;
  end else begin
    q_ah_o <= data_i;
  end
end

// Second usage of rst_n_i: Interpreted as Active Low Asynchronous Reset
always @(posedge clk_i or negedge rst_n_i) begin
  if (!rst_n_i) begin // This condition implies active-low reset
    q_al_o <= 1'b0;
  end else begin
    q_al_o <= q_ah_o; // Use q_ah_o to avoid unused signal warnings
  end
end

endmodule
