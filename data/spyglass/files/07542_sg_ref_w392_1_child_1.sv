module w392_ex1(q1,q2,data_in,clk,rst);
input data_in;
input clk;
input rst;
output q1,q2;
reg q1,q2;

wire rst_inv = !rst; // Create an inverted version of rst to ensure consistent polarity usage

always @(posedge clk or posedge rst) begin
  if (rst) // rst used as active-high reset
    q1 <= 1'b0;
  else
    q1 <= data_in;
end

always @(posedge clk or posedge rst_inv) begin // rst_inv used as active-high reset
  if (rst_inv) // Functionally equivalent to original active-low rst
    q2 <= 1'b0;
  else
    q2 <= data_in;
end
endmodule
