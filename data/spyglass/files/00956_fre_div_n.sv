module fre_div_n #(parameter N = 4) (
    input wire clk_in,
    input wire rst,
    output reg clk_out
);
reg [$clog2(N)-1:0] count;
always @(posedge clk_in or posedge rst) begin
if (rst) begin
count <= 0;
clk_out <= 0;
end else begin
count <= count + 1;
if (count == (N/2 - 1)) begin
clk_out <= ~clk_out;
count <= 0;
end
end
end
endmodule
