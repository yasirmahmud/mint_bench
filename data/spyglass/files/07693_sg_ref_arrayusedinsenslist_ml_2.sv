module ArrayUsedInSensList_ex2(input clk, output reg out);
 reg [7:0] data_array [0:3];
 always @(data_array) begin out = data_array[0][0];
 end endmodule
