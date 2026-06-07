module multiple_iff_violation_1 (
  input clk,
  input rst,
  input enable_clk,
  input enable_rst,
  input data_in,
  output reg data_out
);

  always @(posedge clk iff enable_clk or posedge rst iff enable_rst) begin
    if (rst) begin
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
