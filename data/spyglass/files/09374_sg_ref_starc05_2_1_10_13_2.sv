module star_ex2 (output reg q);
 initial begin q = 1'b0;
 #10 q = 1'b1;
 #20 q = 1'b0;
 end endmodule
