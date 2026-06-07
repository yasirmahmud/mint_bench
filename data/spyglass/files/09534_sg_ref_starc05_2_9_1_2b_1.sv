module star_c05_2_9_1_2b_ex1;
 reg [7:0] limit;
 reg [7:0] i;
 initial begin limit = 10;
 for (i = 0; i < limit; i = i + 1) begin $display("i = %0d", i);
 end end endmodule
