module example1_unuv (
  input wire clk,
  input wire rst,
  input wire data_in,
  output reg data_out
);

  always @(posedge clk or posedge rst or data_in) begin // data_in is in sensitivity list
    if (rst) begin
      data_out = 1'b0;
    end else begin
      data_out = clk; // data_in is NOT used within the block
    end
  end

endmodule
