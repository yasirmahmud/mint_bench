module gated_reset_ex1(input rst, input gating_sig, input en, input d, output reg q);
wire gated_rst;
assign gated_rst = rst & gating_sig;
always @(en or gated_rst or d) begin if (gated_rst) begin q = 1'b0;
 end else if (en) begin q = d;
 end end endmodule
