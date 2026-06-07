module top_module_ex1;
 wire my_a;
 wire my_b; // Added to connect the output 'b' of inst_sub
 assign my_a = 1'b0; // Driven 'my_a' to resolve undriven input warning
 sub_module inst_sub (.a(my_a), .b(my_b)); // Connected output 'b'
 endmodule
