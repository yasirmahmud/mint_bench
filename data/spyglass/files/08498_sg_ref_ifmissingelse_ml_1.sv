module IfMissingElse_ML_ex1;
 reg [0:0] x;
 initial begin x = 1'b0;
 unique if (x == 1'b1) $display("A");
 end endmodule
