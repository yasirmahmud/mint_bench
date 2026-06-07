module jk_t_ff(j,k,clk,rst,q,qbar);
input clk,j,k,rst;
output q,qbar;
wire w1, w2, w3; // Declare internal wires to avoid implicit wire creation warnings/errors
and a1(w1,k,q);
and a2(w2,j,qbar);
or a3(w3,w1,w2);
T_ff1 a4(w3,clk,rst,q,qbar);
endmodule
