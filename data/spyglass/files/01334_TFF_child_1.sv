module tff(
   input t,clk,rst,
	output reg q
    );
always@(posedge clk or negedge rst)
begin

if(!rst) // Asynchronous active-low reset
begin
q <= 1'b0;
end

else // Synchronous logic on rising clock edge
begin
    if(t==1'b1) // Toggle Q when T is high
    begin
    q <= ~q;
    end
    // else (t == 1'b0), Q maintains its current state implicitly
end


endmodule
