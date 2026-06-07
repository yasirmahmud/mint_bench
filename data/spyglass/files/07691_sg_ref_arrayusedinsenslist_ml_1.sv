module ArrayUsedInSensList_ex1;
 reg [7:0] my_array [0:3];
 reg out_reg;
 always @(my_array) begin out_reg = my_array[0][0];
 end endmodule
