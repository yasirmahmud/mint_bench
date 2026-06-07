module synthifstmt_ex1 (input in_sig, output reg out_sig);
 always @* begin if ($test$plusargs("ENABLE_FEATURE")) begin out_sig = in_sig;
 end else begin out_sig = ~in_sig;
 end end endmodule
