module CLKGATETST_X1 ( CK, E, SE, GCK );
  input CK, E, SE;
  output GCK;

  reg enable_reg;

  // Behavioral model for a clock gating cell with a test enable (SE).
  // The enable signal 'E' is latched by the falling edge of 'CK'.
  // 'SE' (Test Enable) is often used to force the gate open (pass clock)
  // for test purposes, overriding the normal enable logic.
  always @(posedge SE or negedge CK) begin
    if (SE) begin
      // When SE is active (high), force the enable high to allow clock propagation (gate open).
      enable_reg <= 1'b1;
    end else begin
      // When SE is inactive, normal clock gating occurs:
      // Latch the enable signal 'E' on the negative edge of 'CK'.
      if (!CK) begin
        enable_reg <= E;
      end
    end
  end

  // The gated clock 'GCK' follows 'CK' only when 'enable_reg' is high.
  // Otherwise, 'GCK' is held low.
  assign GCK = enable_reg ? CK : 1'b0;
endmodule
