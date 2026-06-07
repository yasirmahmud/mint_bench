module D_ff1(D,clk,rst,q,qbar);
input clk,rst,D;
output reg q,qbar;
always@(posedge clk)
begin
if(rst)
{q,qbar}={1'b0,1'b0};
else
    {q,qbar}={D,~D};
    end
endmodule
