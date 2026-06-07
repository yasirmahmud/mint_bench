module my_module_ex1;
 reg [3:0] data_bus;
 wire msb_read;
 assign msb_read = data_bus[3];
 endmodule
