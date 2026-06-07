module starc_2_9_2_3_ex2;
reg [7:0] data_array [0:11];
reg flag;
integer i;
initial begin flag = 1'b0;
for (i = 0; i <= 11; i = i + 1) begin if (data_array[i] == 8'hA) begin flag = 1'b1;
 end end end endmodule
