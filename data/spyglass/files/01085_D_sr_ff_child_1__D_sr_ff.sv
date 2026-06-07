module D_sr_ff(D,clk,rst,q,qbar);
input D,clk,rst;
output  q,qbar;
wire w1,w2,w3;

not a5(w3,D);

and a2(w2,w3,q);
and a4(w1,D,qbar);
sr_ff2 a3(w1,w2,clk,rst,q,qbar);
endmodule
