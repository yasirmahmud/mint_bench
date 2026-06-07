module day12 #(
  parameter WIDTH = 4)
  (input wire [WIDTH -1:0] gray_i,
   output wire [WIDTH -1:0] binary_o);
  
  assign binary_o[WIDTH-1] = gray_i[WIDTH-1];
  
  genvar i;
  for(i=WIDTH-2; i>=0 ;i=i-1)
    assign binary_o[i] = gray_i[i] ^ gray_i[i+1];
  
endmodule
