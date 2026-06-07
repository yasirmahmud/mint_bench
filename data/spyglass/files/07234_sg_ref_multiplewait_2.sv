module MultipleWait_ex2;
 reg clk;
 initial begin clk = 0;
 forever #5 clk = ~clk;
 end initial begin wait (clk);
 wait (clk);
 end endmodule
