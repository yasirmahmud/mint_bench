module star_ex1 (a);
 input a;

 // Fix for W240: Input 'a' declared but not read.
 // Assign 'a' to an internal dummy wire to ensure it is read, preserving port integrity.
 wire unused_a;
 assign unused_a = a;

 endmodule
