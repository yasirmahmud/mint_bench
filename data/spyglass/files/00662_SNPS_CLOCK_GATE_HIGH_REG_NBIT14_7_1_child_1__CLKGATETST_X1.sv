module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);
  reg en_q;

  always @* begin
    if (!CK) begin // Latch is transparent when CK is low
      en_q = E | SE; // Enable or Test Enable
    end
    // When CK is high, en_q holds its value (latch opaque)
  end

  assign GCK = CK & en_q; // GCK is high only when CK is high AND en_q is high
endmodule
