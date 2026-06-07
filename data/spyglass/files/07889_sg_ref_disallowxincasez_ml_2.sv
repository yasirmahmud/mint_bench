module my_module_ex2 (input [1:0] sel, output reg out);
 always @(*) begin out = 1'b0;
 casez (sel) 2'b0x: out = 1'b1;
 2'b10: out = 1'b0;
 default: out = 1'b0;
 endcase end endmodule
