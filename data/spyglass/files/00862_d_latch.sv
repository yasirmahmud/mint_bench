module D_Latch(D,clk,Q);
input D,clk;
output reg Q;

always@(D,clk)
begin
	Q = Q;
	if(clk)
		Q = D;
	else
		Q = Q;
end

endmodule
