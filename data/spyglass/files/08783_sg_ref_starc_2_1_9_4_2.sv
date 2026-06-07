module st_2_1_9_4_ex2;
 parameter P = 8;
 reg [P-1:0] data;
 initial $display("Size of data: %0d", data.size);
 endmodule
