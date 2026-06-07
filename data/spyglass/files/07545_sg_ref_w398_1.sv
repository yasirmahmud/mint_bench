module W398_ex1(input [2:0] choice, output reg out);
 always @(*) begin out = 1'b0;
 casex (choice) 3'b100: out = 1'b1;
 3'b10?: out = 1'b0;
 default: out = 1'b0;
 endcase end endmodule
