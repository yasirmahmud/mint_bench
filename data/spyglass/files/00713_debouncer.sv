module debouncer ( /*AUTOARG*/
// Outputs
button_o, 
// Inputs
rst_i, clk_i, button_i
);


parameter CW = 8;

input        rst_i;
input        clk_i;     // 1us period for a (1<<CW)us debounce interval
input        button_i;
output       button_o;

reg          button_1;
reg          button_2;
reg [CW-1:0] count;
reg          button_o;

wire         changed  =   button_2 ^ button_o;

always @( posedge clk_i or posedge rst_i )
if( rst_i )
begin
          button_1 <= 1'b0;
          button_2 <= 1'b0;
          count    <= {CW{1'b0}};
          button_o <= 1'b0;
end
else
begin
          button_1 <= button_i;       // async input
          button_2 <= button_1;

          count    <= count + 1'b1;

 casex( { changed, &count } )

  2'b0x:  count    <= {CW{1'b0}};    // output == input; reset counter

  2'b10: ;                           // output != input; wait for debounce timeout...

  2'b11:  button_o <= button_2;      // copy input to output

 default: ;
 endcase

end

endmodule
