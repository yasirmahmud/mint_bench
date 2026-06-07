module tristate_sig_ex2 (
  input clk,
  input rst,
  input in1,
  output r1
);

  // Internal register to hold the data when the output is not tristated.
  // This register will be synthesized as a flip-flop.
  reg r1_data_q;
  
  // Internal register to control the tristate enable signal.
  // This register will also be synthesized as a flip-flop.
  reg r1_enable_q;

  always @(posedge clk) begin
    if (rst == 1'b0) begin
      // When reset is active (low), the output should be tristated (Z).
      // The data register can hold a default value, as it won't be driven out.
      r1_data_q   <= 1'b0;
      // De-assert the enable signal to put 'r1' into a high-impedance state.
      r1_enable_q <= 1'b0;
    end else begin
      // When not in reset, the output should drive 'in1'.
      r1_data_q   <= in1;
      // Assert the enable signal to drive 'r1_data_q' to the output.
      r1_enable_q <= 1'b1;
    end
  end

  // Use a continuous assignment to implement the tristate functionality.
  // This separates the sequential logic (r1_data_q, r1_enable_q) from the tristate driver,
  // which is generally preferred for synthesis and resolves the SpyGlass violation.
  assign r1 = r1_enable_q ? r1_data_q : 1'bz;

endmodule
