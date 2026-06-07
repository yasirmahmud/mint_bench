module my_module_ex2 (input a);
  // Fix for W240: Input 'a' declared but not read.
  // Assign 'a' to a dummy internal wire to ensure it is read,
  // preserving the module's interface and the absence of external outputs.
  wire unused_a;
  assign unused_a = a;
endmodule
