module ConcatenationInArrayAssign_ex1;
 reg [7:0] my_array [0:1];
 initial begin my_array = {8'hAA, 8'hBB};
 end endmodule
