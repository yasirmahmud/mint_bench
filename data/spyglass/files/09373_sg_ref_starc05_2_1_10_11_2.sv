module my_module_ex2(input clk, output [7:0] out_bus);
 trireg [7:0] my_bus_reg;
 assign out_bus = my_bus_reg;
 endmodule
