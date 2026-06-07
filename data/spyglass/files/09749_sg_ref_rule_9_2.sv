module my_nand_ex2(input a, b, output y);
 wire internal_po;
 nand g1(internal_po, a, b);
 assign y = 1'b0;
 endmodule
