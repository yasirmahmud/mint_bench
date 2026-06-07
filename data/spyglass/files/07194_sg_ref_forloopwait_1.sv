module ForLoopWait_ex1;
reg [3:0] r_data;
integer i;
initial begin for (i = 0; i < 4; i = i + 1) begin #1;
 r_data = i;
 end end endmodule
