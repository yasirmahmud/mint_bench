module gated_reset_latch_ex2 (input enable_i, input rst_i, input gating_sig_i, input data_i, output reg q_o);
 wire gated_rst;
 assign gated_rst = rst_i & gating_sig_i;
 always @(enable_i or gated_rst or data_i) begin
   if (gated_rst) begin
     q_o <= 1'b0;
   end else if (enable_i) begin
     q_o <= data_i;
   end else begin
     // Explicitly retain the previous value to avoid latch inference violation.
     q_o <= q_o;
   end
 end
endmodule
