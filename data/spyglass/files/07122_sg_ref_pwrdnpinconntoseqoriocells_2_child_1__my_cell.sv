module my_cell (input PWRDN, input in_a, output out_z);
 assign out_z = in_a;
 wire _unused_pwrdn = PWRDN; // Added to resolve W240: Input 'PWRDN' declared but not read.
 endmodule
