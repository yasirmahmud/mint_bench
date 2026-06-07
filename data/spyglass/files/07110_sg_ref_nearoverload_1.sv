module near_overload_ex1;
 reg a, b;
 wire out_nand;
 wire dummy_load[0:8];
 nand (out_nand, a, b);
 buf (dummy_load[0], out_nand);
 buf (dummy_load[1], out_nand);
 buf (dummy_load[2], out_nand);
 buf (dummy_load[3], out_nand);
 buf (dummy_load[4], out_nand);
 buf (dummy_load[5], out_nand);
 buf (dummy_load[6], out_nand);
 buf (dummy_load[7], out_nand);
 buf (dummy_load[8], out_nand);
 endmodule
