module mem_conflict_ex2 (input clk, input en1, input en2, input [1:0] addr, input [7:0] data_in1, input [7:0] data_in2);
 reg [7:0] my_mem [0:3];
 always @(posedge clk) begin
  if (en1) begin
   my_mem[addr] <= data_in1;
  end else if (en2) begin
   my_mem[addr] <= data_in2;
  end
 end
 endmodule
