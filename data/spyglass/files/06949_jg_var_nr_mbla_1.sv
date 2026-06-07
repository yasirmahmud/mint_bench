module multiple_blocking_assign_seq (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    data_out = 1'b0;
  end else begin
    data_out = data_in;       // First blocking assignment
    data_out = ~data_in;      // Second blocking assignment to data_out
  end
end

endmodule
