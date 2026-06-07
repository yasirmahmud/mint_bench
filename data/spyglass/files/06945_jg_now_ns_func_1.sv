module now_func_example1 (
  input wire clk,
  input wire rst,
  output reg [63:0] current_time_val
);

always @(posedge clk or posedge rst) begin
  if (rst) begin
    current_time_val <= 64'h0;
  end else begin
    current_time_val <= $time; // Non-synthesizable function
  end
end

endmodule
