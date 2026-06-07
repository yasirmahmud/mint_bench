module infiniteloop_ex2();
 reg clk;
 initial begin clk = 0;
 forever begin clk = ~clk;
 #10;
 end end endmodule
