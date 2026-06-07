module LATCH_N_GENERIC (
  input EN_N, // Latch enable (active low: transparent when low)
  input D,    // Data input
  output Q    // Latch output
);

  reg q_reg;

  always @(D or EN_N) begin
    if (!EN_N) begin // When EN_N is low, the latch is transparent and captures D
      q_reg = D;
    end
    // When EN_N is high, q_reg holds its current value.
  end

  assign Q = q_reg;

endmodule
