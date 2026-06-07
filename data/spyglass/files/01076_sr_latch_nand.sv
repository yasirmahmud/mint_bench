module sr_latch_nand(s,r,q,q_bar);
input s,r;
output q,q_bar;
nand a1(q,s,q_bar);
nand a2(q_bar,r,q);
endmodule
