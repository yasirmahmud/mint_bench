module overload_ex2 (input a, output z);
 wire out_g1;
 wire z1, z2, z3, z4, z5, z6, z7, z8, z9, z10;
 buf g1 (out_g1, a);
 buf g2 (z1, out_g1);
 buf g3 (z2, out_g1);
 buf g4 (z3, out_g1);
 buf g5 (z4, out_g1);
 buf g6 (z5, out_g1);
 buf g7 (z6, out_g1);
 buf g8 (z7, out_g1);
 buf g9 (z8, out_g1);
 buf g10 (z9, out_g1);
 buf g11 (z10, out_g1);
 assign z = z1;
 endmodule
