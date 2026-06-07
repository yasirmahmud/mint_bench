module w491_ex1;
 reg [1:0] sel;
 reg out;
 always @(*) begin case (sel) 2'b?1: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
