module begin (
  input clk,
  input enable,
  output reg data_out
);

  // Minimal logic to avoid unused signals
  always @(posedge clk) begin
    if (enable) begin
      data_out <= 1'b1;
    end else begin
      data_out <= 1'b0;
    end
  end

endmodule
