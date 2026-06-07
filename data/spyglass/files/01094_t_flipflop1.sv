module t_flipflop1(
    input t,clk,rst,
    output reg q,qbar
    ); 
    always@(negedge clk)
    begin
    if(rst)
    begin
    q=0;qbar=1;
    end
    else begin
     q=(t&~q)|(~t&q);
     qbar=~q;
    end
    end
endmodule
