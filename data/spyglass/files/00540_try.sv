module try  (input j,k, clk,resetn,output reg q, output qbar);


assign qbar = q;

always@( posedge clk)
begin
if(!resetn)
q<=1'b0;
else
begin
case({j,k})
00: q <= q;
01: q <= 1'b0;
10: q <= 1'b1;
11: q <= qbar;
default: q <= 1'bx;
endcase
end
end
endmodule
