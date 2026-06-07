module example_wait_1 (
  input wire clk,
  input wire rst_n,
  input wire enable_sig,
  input wire data_in,
  output reg data_out
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    data_out <= 1'b0;
  end else begin
    wait (enable_sig == 1'b1) data_out <= data_in;
  end
end

endmodule
