module tff(
   input t,clk,rst,
	output reg q
    );
always@(negedge clk)
begin

if(rst==1)
begin
q=1'b0;
end

else
    if(t==0)
    begin
    q=q;
    end

    else if(t==1)
    begin
    q=~q;
    end

end


endmodule
