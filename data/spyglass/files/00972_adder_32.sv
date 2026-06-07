module adder_32(a,b,sum,carry_out);
parameter N=32;
input [N-1:0] a,b;
output[N-1:0] sum;
output carry_out;
wire [N-1:0] carry;

genvar i;
generate
for(i=0;i<N;i=i+1)
begin 
if(i==0)
halfadder_beh g1(.a(a[0]),.b(b[0]),.c(carry[0]),.s(sum[0]));
else

 fa_str g2(.sum(sum[i]),.c_out(carry[i]),.a(a[i]),.b(b[i]),.c_in(carry[i-1]));
 
  assign carry_out = carry[N-1];
end
endgenerate
endmodule
