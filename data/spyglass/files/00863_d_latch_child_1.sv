module D_Latch(D,clk,Q);
input D,clk;
output reg Q;

always@(D,clk)
begin
	if(clk)
		Q = D;
	// Implicitly holds Q's value when clk is low, implementing latch behavior.
	// Q is only written to, not read within this always block, resolving W122.
end

endmodule
