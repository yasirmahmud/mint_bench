module star_ex1 (input [1:0] sel, output reg out);
 always @(*) begin out = 0;
 case (sel) 2'b01: out = 1;
 2'b01: out = 2;
 default: out = 0;
 endcase end endmodule
