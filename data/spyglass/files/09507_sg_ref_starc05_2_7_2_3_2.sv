module starc05_2_7_2_3_ex2 (input wire [1:0] sel, output reg out);
 always @(*) begin case (sel) 2'b00: ;
 2'b01: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
