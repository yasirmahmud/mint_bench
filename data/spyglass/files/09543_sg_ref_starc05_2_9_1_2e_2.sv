module star_ex2;
 reg i;
 initial begin for (i = 0; i < 2; i = i + 1) begin end $display("i = %0d", i);
 end endmodule
