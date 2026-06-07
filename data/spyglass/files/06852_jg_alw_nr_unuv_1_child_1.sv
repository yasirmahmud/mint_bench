module example1_unuv (
  input wire clk,
  input wire rst,
  input wire data_in,
  output reg data_out
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      data_out = 1'b0;
    end else begin
      data_out = clk;
    end
  end

endmodule
