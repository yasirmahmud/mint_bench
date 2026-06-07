module star_case_ex1(input [1:0] sel, input a, input b, output reg out);
 always @(*) begin case (sel) 2'b00: out = a;
 2'b01: out = b;
 endcase end endmodule
