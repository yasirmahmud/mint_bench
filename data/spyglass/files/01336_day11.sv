module day11 #(
  	parameter WIDTH =4)
  (
    input wire [WIDTH -1 :0] bin_i,
    output wire [WIDTH -1:0] gray_o
  );
  
  genvar i;
  for(i= WIDTH-2; i>=0; i=i-1)
    assign gray_o[i] = bin_i[i+1] ^ bin_i[i];
  
  assign gray_o[WIDTH-1] = bin_i[WIDTH-1];
  
endmodule
