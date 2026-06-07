module curve_w415_20260111_154018_082911_w11684_attempt4 (
  input wire in_a,
  input wire in_b,
  output reg target_signal
);

  // This always block drives 'target_signal' based on 'in_a'.
  always @* begin
    target_signal = in_a;
  end

  // This separate always block also drives 'target_signal' based on 'in_b'.
  // Since 'target_signal' is a 'reg' and driven by two distinct 'always' blocks
  // simultaneously, it creates a multiple driver violation (W415).
  always @* begin
    target_signal = in_b;
  end

endmodule
