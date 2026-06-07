module lint_ex1;
 reg [7:0] r;
 integer i;
 always @* begin 
  r = 0;
  for (i = 0; i < 8; i = i + 1) begin 
   r = r | i | (i + 1);
  end 
 end 
endmodule
