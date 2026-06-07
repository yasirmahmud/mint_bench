module SimSynthMismatchInVarInit_ex1 (output reg my_output);
 reg my_reg = 1'b0; // Initialize my_reg at declaration to ensure consistent behavior for simulation and synthesis
 assign my_output = my_reg;
 endmodule
