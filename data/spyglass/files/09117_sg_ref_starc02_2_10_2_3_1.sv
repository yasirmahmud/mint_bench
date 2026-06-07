module star_ex1(input [1:0] vec_in, output reg out);
 always @(*) begin out = !vec_in;
 end endmodule
