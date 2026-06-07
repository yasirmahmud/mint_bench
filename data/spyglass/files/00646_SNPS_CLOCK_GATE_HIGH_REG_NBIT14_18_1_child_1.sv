module CLKGATETST_X1 (
	CK, 
	E, 
	SE, 
	GCK
);

   input CK;
   input E;
   input SE;
   output GCK;

   reg latched_enable;

   // Negative-level sensitive latch for the enable signal
   // When CK is low, 'latched_enable' follows 'E' OR 'SE'.
   // When CK is high, 'latched_enable' holds its previous value.
   always @(E or SE or CK) begin
     if (!CK) begin
       latched_enable = E | SE;
     end
   end

   // Glitch-free gated clock output
   // GCK is the AND of the input clock and the latched enable.
   assign GCK = CK & latched_enable;

endmodule
