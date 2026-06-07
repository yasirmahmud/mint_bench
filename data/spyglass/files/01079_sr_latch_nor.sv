module sr_latch_nor(s,r,q,q_bar);
input s,r;
output q,q_bar;
nor a1(q,s,q_bar);
nor a2(q_bar,r,q);
endmodule
