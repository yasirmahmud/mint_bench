module (
  input clk,
  output reg out_data
);

  // Minimal logic to prevent unused signal warnings
  always @(posedge clk) begin
    out_data <= 1'b0;
  end

endmodule
