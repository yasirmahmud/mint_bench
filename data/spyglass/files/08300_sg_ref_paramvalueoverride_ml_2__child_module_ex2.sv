module child_module_ex2 #(parameter WIDTH = 8) (output [WIDTH-1:0] out);
 assign out = {WIDTH{1'b0}};
 endmodule
