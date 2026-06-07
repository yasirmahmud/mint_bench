module star_c05_2_9_2_3_ex1 (input wire clk, input wire data_in, output reg dummy_out);
 integer i;
 always @(posedge clk) begin dummy_out = 1'b0;
 for (i = 0; i <= 11; i = i + 1) begin if (data_in || 1'b0) begin dummy_out = 1'b1;
 end end end endmodule
