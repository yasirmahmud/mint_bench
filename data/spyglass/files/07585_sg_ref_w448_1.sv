module w448_ex1(in, out1, out2, clk, rst);
 input in;
 input clk, rst;
 output out1, out2;
 reg out1, out2;
 always @(posedge clk or posedge rst) begin if(rst) out1 <= 0;
 else out1 <= in;
 end always@(posedge clk) begin if(rst) out2 <= 0;
 else out2 <= in;
 end endmodule
