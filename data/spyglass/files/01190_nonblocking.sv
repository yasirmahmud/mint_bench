module nonblocking(
clk,rst
    );
    input clk,rst;
    reg [1:0] a,b,c;
    always@(*)begin
        if(!rst)begin 
            a <= 2'd1;
            b <= 2'd2;
            c <= 2'd3;
        end
        else begin
            a <= c;
            b <= a;
            c <= b;
        end
    end
endmodule
