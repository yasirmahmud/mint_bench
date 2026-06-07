module my_cell (input PWRDN, input in_a, output out_z);
 assign out_z = in_a;
 // Removed: wire _unused_pwrdn = PWRDN; // Removed to resolve W528
 endmodule
