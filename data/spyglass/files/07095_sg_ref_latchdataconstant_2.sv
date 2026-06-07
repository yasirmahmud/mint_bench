module LatchDataConstant_ex2 (input wire en, output reg q);
 wire rst_n_tied_high = 1'b1;
 wire d_constant = 1'b0;
 always @(en or rst_n_tied_high) begin if (!rst_n_tied_high) begin q = 1'b0;
 end else if (en) begin q = d_constant;
 end end endmodule
