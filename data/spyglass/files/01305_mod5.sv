module mod5(clk,mod,rst,updown,count);
input clk,rst,updown;
input [2:0] mod;
output reg [2:0]count;

always@(posedge clk)
    begin

        if(rst ||(count == mod-1))
            count <= 0;

        else if(updown)
            count <= count +1 ;
    end

always@(posedge clk)
    begin

        if(rst)
            count <= 0;

         else if(!updown && count == 0 )
          count <= mod-1 ;

        else if(!updown)
            count <= count - 1 ;
    end

endmodule
