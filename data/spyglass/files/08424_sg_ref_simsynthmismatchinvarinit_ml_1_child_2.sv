module SimSynthMismatchInVarInit_ex1 (output reg my_output);
 reg my_reg;
 initial begin
 my_reg = 1'b0;
 my_output = my_reg;
 end
 endmodule
