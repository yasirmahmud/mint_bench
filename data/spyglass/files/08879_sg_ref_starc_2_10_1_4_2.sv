module starc_2_10_1_4_ex2(input wire [1:0] in_sig, output reg out_val);
 always @(*) begin if (in_sig === 2'b1x) begin out_val = 1'b1;
 end else begin out_val = 1'b0;
 end end endmodule
