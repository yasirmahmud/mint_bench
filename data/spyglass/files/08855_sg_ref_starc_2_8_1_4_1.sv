module missing_default_ex1(input [1:0] sel, input in1, output reg out);
 always @(*) begin case (sel) 2'b00: out = in1;
 2'b01: out = ~in1;
 endcase end endmodule
