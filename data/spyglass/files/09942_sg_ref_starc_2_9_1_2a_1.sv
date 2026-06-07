module star_2_9_1_2a_ex1 (input [7:0] start_val, output reg [7:0] out_reg);
 integer i;
 always @(*) begin for (i = start_val; i < 10; i = i + 1) begin out_reg = i;
 end end endmodule
