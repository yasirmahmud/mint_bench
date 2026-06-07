module srlatch(input s,r,output q,qbar);

nor(qbar,s,q);
nor(q,r,qbar);

endmodule
