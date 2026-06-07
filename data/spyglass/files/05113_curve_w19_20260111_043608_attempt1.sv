module curve_w19_20260111_043608_attempt1 (
  input wire clk,
  input wire rst,
  output reg [9:0] data_out
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      data_out <= 10'b0;
    end else begin
      // W19: Constant 10'h00FF will be truncated.
      // SpyGlass likely interprets 'h00FF' as implicitly wider (e.g., 16-bit),
      // and then truncates it to the explicitly specified 10 bits.
      data_out <= 10'h00FF;
    end
  end

endmodule
