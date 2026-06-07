module IfOverlap_ML_ex2;
 wire [1:0] sel;
 reg out;
 always @* begin if (sel == 2'b0) out = 1'b0;
 else if (sel == 2'b0) out = 1'b1;
 else out = 1'b0;
 end endmodule
