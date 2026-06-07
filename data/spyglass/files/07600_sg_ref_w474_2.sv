module w474_ex2 (input [7:0] in_data, output reg [7:0] out_data);
 reg [7:0] my_reg;
 always @* begin assign my_reg = in_data;
 out_data = my_reg;
 end endmodule
