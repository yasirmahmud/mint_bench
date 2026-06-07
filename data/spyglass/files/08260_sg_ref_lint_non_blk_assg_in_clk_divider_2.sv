module clock_divider_ex2(input clk, input rst, output reg clk_div);
 reg [1:0] counter;
 always @(posedge clk or posedge rst) begin if (rst) begin counter <= 2'b0;
 clk_div <= 1'b0;
 end else begin if (counter == 2'd1) begin counter <= 2'b0;
 clk_div <= ~clk_div;
 end else begin counter <= counter + 1;
 end end end endmodule
