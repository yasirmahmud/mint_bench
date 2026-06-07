module w481b_ex1;
 reg [3:0] i;
 reg [3:0] j;
 initial begin for (i = 0; j < 10; j = j + 1) begin $display("j = %0d", j);
 end end endmodule
