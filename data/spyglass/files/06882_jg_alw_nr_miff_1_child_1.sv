module multiple_iff_violation_1 (
  input clk,
  input rst,
  input enable_clk,
  input enable_rst,
  input data_in,
  output reg data_out
);

  // Original intent of 'iff' in sensitivity list is interpreted as
  // a gated asynchronous reset and a synchronous clock enable.
  // 'posedge rst iff enable_rst' -> reset is active when rst AND enable_rst are high.
  // 'posedge clk iff enable_clk' -> data updates only when enable_clk is high.
  always @(posedge clk or posedge rst) begin
    if (rst && enable_rst) begin // Asynchronous reset, gated by enable_rst
      data_out <= 1'b0;
    end else begin
      if (enable_clk) begin // Synchronous data update, enabled by enable_clk
        data_out <= data_in;
      end
    end
  end

endmodule
