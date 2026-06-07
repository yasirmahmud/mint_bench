module debug_init_assign_ex2;
 reg [7:0] my_vec;
 initial begin my_vec = 8'hFF;
 my_vec[3:0] = 4'h0;
 end endmodule
