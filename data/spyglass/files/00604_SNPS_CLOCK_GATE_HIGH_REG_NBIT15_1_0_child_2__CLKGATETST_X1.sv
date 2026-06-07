module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg enable_latch;

  // Latch the enable signal 'E' when 'CK' is low (negative-transparent latch)
  // Using 'always_latch' to explicitly declare the intended latch behavior,
  // resolving the 'InferLatch' violation while preserving functionality.
  always_latch begin
    if (!CK) begin
      enable_latch <= E;
    end
  end

  // Output 'GCK' based on 'CK', latched 'E', and 'SE'
  // If SE (Test Enable) is asserted, it bypasses the clock gate and passes CK directly.
  // Otherwise, GCK passes CK only if the enable_latch is high.
  assign GCK = SE ? CK : (enable_latch ? CK : 1'b0);

endmodule
