module multiple_resets_ex2(input clk, input rst1, input rst2, input data, output reg q);
 always @(posedge clk or negedge rst1 or negedge rst2) begin 
  if (rst1 == 1'b0 || rst2 == 1'b0) 
   q <= 1'b0;
  else 
   q <= data;
 end 
endmodule
