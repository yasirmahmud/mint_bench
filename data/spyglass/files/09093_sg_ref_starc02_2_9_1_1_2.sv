module complex_for_ex2();
 reg [7:0] data_vec;
 integer i;
 initial begin data_vec = 8'hAA;
 for (i = 0; i < 7; i = i + 1) begin data_vec[i+1] = data_vec[i];
 end end endmodule
