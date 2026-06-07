module star_ex2(input [2:0] data_in, output reg out_reg);
 always @* begin if (data_in == 3'bxxx) out_reg = 1'b1;
 else out_reg = 1'b0;
 end endmodule
