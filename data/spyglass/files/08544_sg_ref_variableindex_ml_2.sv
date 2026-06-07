module VariableIndex_ML_ex2;
 reg [7:0] my_array [0:3];
 reg [1:0] idx;
 reg val;
 always @(*) begin my_array[idx] = val;
 end endmodule
