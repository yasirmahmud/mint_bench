module my_module_ex2 (input clk, input rst, input [7:0] in_data, output reg [7:0] out_data);
 always @(posedge clk or posedge rst) begin if (rst) begin out_data <= 8'h00;
 end else begin integer i = 0;
 while (i < 5) begin out_data <= in_data + i;
 i = i + 1;
 end end end endmodule
