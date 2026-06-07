module T_ff2(T,clk,rst,q,qbar);
input T,clk,rst;
output reg q,qbar;
always@(posedge clk)
begin

if(rst)
{q,qbar}<={1'b0,1'b1};
else
    begin
    if(T==1)
    {q,qbar}<={<(~q),q};
    end
    
end
endmodule
