module dec2x4  (y,a,En);

output reg [3:0]y;
input[1:0]a;
input En;

always@(a,En)
       begin
               if (En==1)
               begin
                     y=4'b0000;
                     y[a]=1;
               end
               else
                     y=4'b0000;     
                     
  end 
endmodule
