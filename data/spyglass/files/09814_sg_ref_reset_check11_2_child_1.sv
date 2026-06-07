module reset_check11_ex2 (input clk, rst, d1, d2, output reg q1, q2);
 wire rst_n = !rst; // Create an inverted reset signal

 always @(posedge clk or posedge rst) begin
  if (rst) q1 <= 1'b0;
  else q1 <= d1;
 end

 always @(posedge clk or posedge rst_n) begin // q2 now uses the inverted reset as active-high
  if (rst_n) q2 <= 1'b0;
  else q2 <= d2;
 end
endmodule
