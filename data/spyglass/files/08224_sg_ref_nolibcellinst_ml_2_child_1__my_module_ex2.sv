module my_module_ex2 (input a, output b);
 wire temp;
 assign temp = a;
 LIB_CELL u_lib_cell (.in(temp), .out(b));
 endmodule
