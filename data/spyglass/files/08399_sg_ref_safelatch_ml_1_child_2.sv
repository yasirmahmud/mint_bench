module SafeLatch_ML_ex1 (input clk1, input clk2, input data_in, output reg q_out);
  wire enable_sig;
  assign enable_sig = clk1 & clk2;
  always @(enable_sig or data_in or q_out) begin
    if (enable_sig) begin
      q_out <= data_in;
    end else begin
      q_out <= q_out; // Explicitly preserve current value when not enabled, making the latch behavior clear.
    end
  end
endmodule
