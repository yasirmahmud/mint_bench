module up(reset,clk,count_out);
input reset,clk;
output [3:0]count_out;
reg [3:0]count_up=4'b0000;
always@(posedge clk)
begin
if(reset)
count_up=4'b0000;
else
count_up=count_up+4'b0001;
end
assign count_out=count_up;
endmodule
