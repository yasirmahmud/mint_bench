module LatchReset_ex1 (input d, input en, input rst, output reg q);
 always @(d or en or rst) begin if (rst && !en) begin q = 1'b0;
 end else if (en) begin if (rst) begin q = 1'b0;
 end else begin q = d;
 end end end endmodule
