module ConstBitCase_ML_ex1;
 reg [1:0] sel;
 always @(*) begin case ({1'b0, sel}) 3'b000: ;
 3'b001: ;
 default: ;
 endcase end endmodule
