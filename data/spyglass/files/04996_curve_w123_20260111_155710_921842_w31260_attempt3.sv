module curve_w123_20260111_155710_921842_w31260_attempt3 (
  input wire in_clk,
  input wire in_rst_n,
  input wire in_data,
  output reg out_data
);

  // W123: "Signal 'Q[1823]' size too big thus not processed"
  // This example declares a 'reg' of an extremely large width (200,001 bits).
  // This width is intended to exceed SpyGlass's internal processing limits for bus sizes,
  // thereby triggering the W123 violation for the 'huge_data_reg' signal.
  // The chosen width (200,001) is different from the previous attempt (150,000).
  reg [200000:0] huge_data_reg;

  always @(posedge in_clk or negedge in_rst_n) begin
    if (!in_rst_n) begin
      // Reset the extremely wide register to all zeros
      huge_data_reg <= {200001{1'b0}};
      out_data <= 1'b0;
    end else begin
      // Implement a simple shift register to use the huge_data_reg and in_data
      huge_data_reg <= {huge_data_reg[199999:0], in_data};
      // Assign a bit from the wide register to the output to prevent unused signal warnings
      out_data <= huge_data_reg[200000];
    end
  end

endmodule
