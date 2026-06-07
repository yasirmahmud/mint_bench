module sr_ff1(s,r,clk,rst,q,qbar);
input s,r,clk,rst;
output reg q,qbar;
always@(posedge clk)
begin
if(rst)
    {q,qbar}<={1'b1,1'b0};
else begin
case({s,r})
 
                2'b00:{q,qbar} <={q,qbar};
            2'b01:
                {q,qbar} <={1'b0,1'b1};
            2'b10:
                {q,qbar} <={1'b1,1'b0};
            2'b11:
               {q,qbar} <={1'bx,1'bx};
            default:
                {q,qbar} <= {q,qbar};
endcase
end
end


endmodule
