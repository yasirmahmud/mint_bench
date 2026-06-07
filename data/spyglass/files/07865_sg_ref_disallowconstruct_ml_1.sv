module disallow_construct_ml_ex1;
 reg [3:0] count;
 initial begin count = 0;
 while (count < 5) begin count = count + 1;
 end end endmodule
