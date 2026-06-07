module my_module_ex1_top;
 wire [7:0] a, b;
 my_module_ex1_sub #(.WIDTH(4)) inst1 (.in(a), .out(b));
 endmodule
