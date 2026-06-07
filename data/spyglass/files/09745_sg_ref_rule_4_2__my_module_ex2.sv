module my_module_ex2 (input a, output z);
 wire multi_net;
 my_cell i1 (.in(a), .out(multi_net));
 my_buf i2 (.in(1'b1), .out(multi_net));
 assign z = multi_net;
 endmodule
