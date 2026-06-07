module not_req_sens_ex2 (input a, input b, input c, output reg out);
 always @(a or b or c) begin if (a) out = b;
 else out = 1'b0;
 end endmodule
