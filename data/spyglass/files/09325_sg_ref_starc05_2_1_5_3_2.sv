module my_module_ex2;
 reg [1:0] condition;
 wire out;
 assign out = condition ? 1'b1 : 1'b0;
 endmodule
