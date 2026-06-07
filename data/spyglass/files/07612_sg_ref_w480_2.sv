module w480_ex2;
 reg [7:0] my_data;
 reg [3:0] i;
 initial begin for (i = 0; i < 8; i = i + 1) begin my_data[i] = 1'b0;
 end end endmodule
