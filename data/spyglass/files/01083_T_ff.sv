module T_FF(t,clk,rst,qn,qn_bar);
input t,clk,rst; output reg qn;output qn_bar; 
always@(posedge clk) 
begin 
if(!rst) 
qn=0;
else 
begin
case(t) 
0:qn=qn;
1:qn=~qn;
endcase 
end
end
assign qn_bar=~qn;
endmodule
