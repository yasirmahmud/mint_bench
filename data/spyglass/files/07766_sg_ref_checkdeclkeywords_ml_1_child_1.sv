module CheckDeclKeywords_ML_ex1;
 reg clk;

 initial begin
  clk = 0;
  forever #5 clk = ~clk;
 end

endmodule
