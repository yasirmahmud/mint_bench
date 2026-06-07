module cla(input [31:0]x,y,input cin,output [31:0]s,output cout);
wire [31:0]c;
integer i;
assign c[0]=cin;
always@(x,y);
initial begin

for(i=0;i<32;i=i+1)
begin
cla_mod cla0(x[i],y[i],c[i],s[i],c[i+1]);
end

end
assign cout=c[31];
endmodule
