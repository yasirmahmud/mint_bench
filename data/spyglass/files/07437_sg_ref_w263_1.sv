module w263_ex1 (input [3:0] sel, output reg out);
 always @(*) begin out = 1'b0;
 case (sel) 8'h01: out = 1'b1;
 4'h2: out = 1'b0;
 default: out = 1'b0;
 endcase end endmodule
