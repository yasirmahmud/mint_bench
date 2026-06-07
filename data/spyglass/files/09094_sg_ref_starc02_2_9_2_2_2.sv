module star_ex2_module (input [7:0] data, output reg out_reg);
 integer i;
 always @(*) begin out_reg = 0;
 for (i = 0; i < 8; i = i + 1) begin if (data[i] == 1'b1) begin out_reg = 1;
 end end end endmodule
