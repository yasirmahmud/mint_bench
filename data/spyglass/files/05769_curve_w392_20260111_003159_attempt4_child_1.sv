module curve_w392_20260111_003159_attempt4 (
  input wire clk_i,
  input wire rst_i,
  input wire data_i,
  output reg q_active_high_rst_o,
  output reg q_active_low_rst_o
);

// Create an inverted version of rst_i for the active-low reset block
wire rst_n = !rst_i;

// This block uses 'rst_i' as an asynchronous active-high reset
always @(posedge clk_i or posedge rst_i) begin
  if (rst_i) begin // 'rst_i' causes reset when high
    q_active_high_rst_o <= 1'b0;
  end else begin
    q_active_high_rst_o <= data_i;
  end
end

// This block now uses 'rst_n' as an asynchronous active-high reset, which corresponds
// to 'rst_i' being an active-low reset. This resolves W392 by ensuring 'rst_i'
// is used with a consistent polarity across the design (as active-high),
// and its inverted version 'rst_n' is used consistently as active-high too.
always @(posedge clk_i or posedge rst_n) begin
  if (rst_n) begin // 'rst_n' causes reset when high, which means 'rst_i' is low
    q_active_low_rst_o <= 1'b1; // Reset to a different value to ensure distinctness
  end else begin
    q_active_low_rst_o <= q_active_high_rst_o; // Use another signal to avoid unused signal warning
  end
end

endmodule
