module BreakInMultiDimForeach_ex2();
 reg [7:0] data[0:1][0:2];
 initial begin
  foreach (data[i,j]) begin
   if (i == 0 && j == 0) break;
  end
 end
endmodule
