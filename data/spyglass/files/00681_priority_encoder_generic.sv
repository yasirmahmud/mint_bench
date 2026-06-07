module priority_encoder_generic #(parameter n = 4) (
input [n-1:0]w,
output reg [$clog2(n)-1:0]y,
output z
);


assign z = |w;

integer i;

always @(w)
begin
	y = 'bx;
	for(i = 0; i < n; i = i + 1)
		if(w[i])
			y = i;
		
end
endmodule
