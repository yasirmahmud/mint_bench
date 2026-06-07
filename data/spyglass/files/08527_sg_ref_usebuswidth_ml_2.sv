module my_module_ex2(input [1:0] in_bus, output [1:0] out_bus);
 reg [1:0] out_bus;
 always @(*) out_bus = in_bus;
 endmodule
