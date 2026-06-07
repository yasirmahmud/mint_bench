module curve_w19_20260111_185833_410544_w53504_attempt6 (
  input wire clk,
  input wire rst_n,
  output reg [4:0] data_out // 5-bit register
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 5'd0; // Reset value
    end else begin
      // W19: Constant '32' (binary 100000) requires 6 bits,
      // but is specified with 5 bits (5'd32), causing truncation.
      data_out <= 5'd32;
    end
  end

endmodule
