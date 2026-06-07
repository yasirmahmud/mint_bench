module STARC_2_9_3_1_ex1;
 reg [7:0] data;
 integer i;
 initial begin
  loop_block: for (i = 0; i < 10; i = i + 1) begin
   if (i == 5) begin
    disable loop_block;
   end
   data = i;
  end
 end
endmodule
