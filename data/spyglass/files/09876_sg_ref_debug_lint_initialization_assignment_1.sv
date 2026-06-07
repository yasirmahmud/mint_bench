module debug_init_assign_ex1;
 reg [7:0] data_bus;
 initial begin data_bus = 8'hFF;
 data_bus[3:0] = 4'h0;
 end endmodule
