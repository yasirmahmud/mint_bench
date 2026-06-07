module MissingCaseItems_ML_ex1(input [1:0] sel, output reg out);
 always @(*) begin unique case(sel) 2'b00: out = 1'b0;
 2'b01: out = 1'b1;
 2'b10: out = 1'b0;
 endcase end endmodule
