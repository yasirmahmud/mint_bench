module STARC05_2_2_3_2_ex2 (input wire clk, input wire rst, input wire data_in, input wire enable, output reg q);
 always @(posedge clk or posedge rst) begin
   if (!rst) begin // Reset condition: rst is active low
     if (enable) begin
       q <= data_in;
     end else begin
       q <= 1'b0;
     end
   end else begin // Not reset: rst is high or transitioned to high
     q <= 1'b0;
   end
 end
endmodule
