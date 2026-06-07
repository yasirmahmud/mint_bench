module star_2_9_2_2_ex1(input wire [9:0] b, output reg out);
 integer i;
 always @(*) begin out = 1'b0;
 for (i = 0; i < 10; i = i + 1) if (b[i] || 1'b0) out = 1'b1;
 end endmodule
