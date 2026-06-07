module d_flipflop(
input d,clk,rst,
output reg q,qbar);
always@(posedge clk)
begin
if(rst)
begin
q=0;
qbar=1;
end
else
begin
q=d;
qbar=~q; 
end
end
endmodule
