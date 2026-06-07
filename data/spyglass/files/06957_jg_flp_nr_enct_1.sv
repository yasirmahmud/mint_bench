module constant_enable_0 (
  input clk,
  input rst_n,
  input data_in,
  output reg q_out
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q_out <= 1'b0;
    end else if (1'b0) begin // Enable is constant 0
      q_out <= data_in;
    end
  end

endmodule
