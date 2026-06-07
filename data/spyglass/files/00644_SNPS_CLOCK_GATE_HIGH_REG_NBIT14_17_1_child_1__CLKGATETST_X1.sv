module CLKGATETST_X1 (
	input CK,
	input E,
	input SE,
	output GCK
);

   reg  en_q; // Latch for the enable signal

   // Standard clock gating cell behavior:
   // - If SE (Test Enable) is high, the enable is forced high (clock always passes).
   // - If SE is low, the enable signal (E) is latched when CK is low (transparent).
   // - When CK goes high, the latch holds the last sampled E.
   // - GCK is the AND of CK and the latched enable (en_q).
   always @(E or CK or SE) begin
      if (SE) begin
         en_q = 1'b1; // Force enable in test mode
      end else if (!CK) begin
         en_q = E; // Latch is transparent when CK is low, samples E
      end
      // When CK is high and SE is low, en_q holds its last value.
   end

   assign GCK = en_q & CK;

endmodule
