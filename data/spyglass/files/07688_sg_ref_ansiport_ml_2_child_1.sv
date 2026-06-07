module my_module_ex2(a);
 input wire a;
 wire a_read;
 assign a_read = a; // Read input 'a' to resolve W240
 endmodule
