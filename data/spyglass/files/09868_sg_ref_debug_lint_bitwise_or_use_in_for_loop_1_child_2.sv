module lint_ex1;
 reg [7:0] r;
 always @* begin 
  r = (0|1) | (1|2) | (2|3) | (3|4) | (4|5) | (5|6) | (6|7) | (7|8);
 end 
endmodule
