module blocking_reg (
  input clk,
  input rst_n,
  input d,
  output reg q
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    q = 1'b0; // Blocking assignment in sequential block
  end else begin
    q = d;    // Blocking assignment in sequential block
  end
end

endmodule
