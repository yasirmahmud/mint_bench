module ConstBitCase_ex2;
reg [1:0] sel;
reg out;
always @(*) begin case ({1'b0, sel}) 3'b000: out = 1'b0;
 3'b001: out = 1'b1;
 3'b010: out = 1'b0;
 3'b011: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
