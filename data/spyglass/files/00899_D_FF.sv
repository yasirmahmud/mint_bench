module d_ff(d,clk,rst,qn);
input d,clk,rst; output reg qn;
always@(posedge clk) 
begin 
if(!rst) 
qn=1'b0; 
else
begin 
case(d) 
1'b0:qn=1'b0;
1'b1:qn=d; 
endcase
end
end
endmodule
