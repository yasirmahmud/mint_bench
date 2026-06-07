module infer_latch_ex1(input wire en, input wire d_in, output reg q_out);
 always @(en or d_in) begin if (en) begin q_out = d_in;
 end end endmodule
