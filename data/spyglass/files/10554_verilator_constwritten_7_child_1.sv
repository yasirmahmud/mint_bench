module const_write_7 (
  input logic clk
);
  logic flag = 1'b0; // Removed 'const' to allow modification
  always @(posedge clk) begin
    flag <= 1'b1;
  end
endmodule
