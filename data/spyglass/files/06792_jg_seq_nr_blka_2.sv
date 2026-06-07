module blocking_counter (
  input clk,
  input rst_n,
  output reg [3:0] count
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    count = 4'b0; // Blocking assignment in sequential block
  end else begin
    count = count + 1; // Blocking assignment in sequential block
  end
end

endmodule
