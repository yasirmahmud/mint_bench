module st_2_9_2_4_ex1 (clk, rst, din);
 input clk, rst, din;
 integer i;
 reg dout;
 always @ (posedge clk or negedge rst) for (i = 0; i < 1; i = i + 1) if (!rst) dout = 1'b0;
 else dout = din;
 endmodule
