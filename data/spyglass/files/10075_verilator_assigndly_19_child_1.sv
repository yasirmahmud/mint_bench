module example_19 (
  input clk,
  input rst_n,
  output reg bb
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      bb <= 1'b0;
    end
    // No other assignments to 'bb' are described in the original design
  end

endmodule
