module constant_loop_ex2;
 reg [7:0] data;
 integer i;
 initial begin for (i = 0; 0; i = i + 1) begin data = i;
 end end endmodule
