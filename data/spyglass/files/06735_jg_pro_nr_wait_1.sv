module wait_example_1 (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    data_out <= 1'b0;
  end else begin
    wait (data_in == 1'b1); // PRO_NR_WAIT: Sensitivity lists should be used instead of wait statement
    data_out <= data_in;
  end
end

endmodule
