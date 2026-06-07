module w442b_ex1 (input clk, input rst, input another_signal, output reg q);
 always @ (posedge clk or posedge rst) begin 
  if (rst) begin // W442b: Changed reset condition to check only 'rst' for an active-high asynchronous reset.
   q <= 1'b0;
  end else begin
   q <= ~q;
  end 
 end 
endmodule
