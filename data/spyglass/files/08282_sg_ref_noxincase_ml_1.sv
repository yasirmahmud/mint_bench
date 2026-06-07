module noxincase_ml_ex1(input [1:0] sel, output reg out);
 always @(*) begin case (2'b1X) 2'b00: out = 1'b0;
 2'b01: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
