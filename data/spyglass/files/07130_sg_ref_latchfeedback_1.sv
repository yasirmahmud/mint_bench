module LatchFeedback_ex1 (input wire en, output reg q_out);
 always @(en or q_out) begin if (en) begin q_out = !q_out;
 end end endmodule
