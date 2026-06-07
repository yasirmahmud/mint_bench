module sync_down_count(
    input rst,clk,
    output reg [3:0] count
    );
    initial count=0;
    always @(posedge clk)
    begin
    if(rst)
    count=0;
    else count=count-1;
    end
endmodule
