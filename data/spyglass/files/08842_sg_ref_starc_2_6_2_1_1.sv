module STARC_2_6_2_1_ex1 (input clk, rst, in1, in2, output reg out1, out2);
 always @(posedge clk or posedge rst) begin if (rst) begin out1 = 1'b0;
 end else begin out1 = in1;
 end case (in2) 1'b0: out2 = 1'b0;
 1'b1: out2 = 1'b1;
 endcase end endmodule
