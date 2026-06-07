module latch_reset_ex2 (input rst, input data, input en, output reg out1, output reg out2);
 always @(rst or data or en) begin if (~rst) out1 <= 1'b0;
 else if (en) out1 <= data;
 end always @(rst or data or en) begin if (rst) out2 <= 1'b0;
 else if (en) out2 <= data;
 end endmodule
