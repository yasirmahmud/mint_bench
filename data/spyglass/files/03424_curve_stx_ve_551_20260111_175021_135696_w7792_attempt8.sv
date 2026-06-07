module initial (
  input clk,
  output reg out_data
);

  always @(posedge clk) begin
    out_data <= 1'b0;
  end

endmodule
