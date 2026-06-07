module async_4bit_down_count  (j,k,clock,reset,q);

input j,k;
input clock,reset;
output [3:0]q;
jk_ff JK1(j,k,clock,reset,q[0]);
jk_ff JK2(j,k,q[0],reset,q[1]);
jk_ff JK3(j,k,q[1],reset,q[2]);
jk_ff JK4(j,k,q[2],reset,q[3]);
endmodule
