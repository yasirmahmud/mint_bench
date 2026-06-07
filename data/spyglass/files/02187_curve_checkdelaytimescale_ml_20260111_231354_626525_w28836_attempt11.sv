module delay_module (
  input wire clk,
  input wire data_in,
  output reg data_out
);

  always @(posedge clk) begin
    data_out <= #3 data_in;
  end

endmodule
