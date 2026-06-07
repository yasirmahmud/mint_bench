module w66_ex2(input clk, input rst, input [3:0] count_in, output reg [7:0] out_reg);
 reg [3:0] dynamic_count;
 always @(posedge clk or posedge rst) begin if (rst) begin dynamic_count <= 4'd1;
 out_reg <= 8'h00;
 end else begin dynamic_count <= count_in;
 repeat (dynamic_count) begin out_reg <= out_reg + 1;
 end end end endmodule
