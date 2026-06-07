module not_req_sens_ex1 (input a, input b, input c, output reg y);
 always @(a or b or c) begin y = a & b;
 end endmodule
