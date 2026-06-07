module ConcatenationInArrayAssign_ex1;
  reg [7:0] my_array [0:1];

  initial begin
    my_array[0] = 8'hAA;
    my_array[1] = 8'hBB;
  end
endmodule
