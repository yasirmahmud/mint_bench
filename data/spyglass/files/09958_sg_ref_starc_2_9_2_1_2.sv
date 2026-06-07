module STARC_2_9_2_1_ex2;
 reg [7:0] a [0:10];
 reg [7:0] b [0:10];
 integer i;
 initial begin for (i=0; i<=10; i=i+1) begin b[i] = i;
 a[i] = b[i] + 1;
 end end endmodule
