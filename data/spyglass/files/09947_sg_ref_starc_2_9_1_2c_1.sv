module st_2_9_1_2c_ex1 (input clk, output reg [3:0] data_out);
 integer i;
 always @(posedge clk) begin for (i = 0; i < 4; i = i + 1) begin data_out[i] = 1'b0;
 i = 2;
 end end endmodule
