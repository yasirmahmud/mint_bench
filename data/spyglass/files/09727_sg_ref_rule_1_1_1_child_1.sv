module my_module_ex1 (input a);
  // To resolve 'Input 'a' declared but not read' (W240),
  // 'a' is assigned to an internal wire to ensure it is read.
  wire unused_a_reader;
  assign unused_a_reader = a;
 endmodule
