module curve_w392_20260111_003159_attempt1 (
  input wire clk_i,
  input wire rst_i,
  input wire data_in_i,
  output reg q_ah_o,
  output reg q_al_o
);

// Create an inverted version of rst_i to resolve W392 violation
wire rst_i_n;
assign rst_i_n = ~rst_i;

// First usage of rst_i: Active High Asynchronous Reset
// This block uses rst_i directly as an active-high reset.
always @(posedge clk_i or posedge rst_i) begin
  if (rst_i) begin // Active-high reset for rst_i
    q_ah_o <= 1'b0;
  end else begin
    q_ah_o <= data_in_i;
  end
end

// Second usage of rst_i: Active Low Asynchronous Reset (via rst_i_n)
// This block uses the inverted reset signal (rst_i_n) as an active-high reset,
// effectively making the reset active-low with respect to the original rst_i.
always @(posedge clk_i or posedge rst_i_n) begin
  if (rst_i_n) begin // Active-high reset for rst_i_n, meaning active-low for rst_i
    q_al_o <= 1'b0;
  end else begin
    q_al_o <= q_ah_o;
  end
end

endmodule
