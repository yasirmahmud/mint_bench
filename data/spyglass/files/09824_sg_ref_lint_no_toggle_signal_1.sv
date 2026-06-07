module LINT_NO_TOGGLE_SIGNAL_ex1 (input clk);
 reg my_signal;
 always @(posedge clk) begin my_signal <= 1'b0;
 end endmodule
