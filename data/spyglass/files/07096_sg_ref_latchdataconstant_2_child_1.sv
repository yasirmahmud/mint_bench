module LatchDataConstant_ex2 (input wire en, output reg q);
 wire rst_n_tied_high = 1'b1;
 wire d_constant = 1'b0;
 
 // The original logic implicitly created a latch for 'q' when 'en' was low.
 // Since 'rst_n_tied_high' is tied to 1'b1, the '!rst_n_tied_high' branch is never taken.
 // The effective logic was 'if (en) q = d_constant;', where d_constant is 1'b0.
 // This meant 'q' would become 0 when 'en' was high, and hold its value (which could only be X or 0) when 'en' was low.
 // To remove the latch, 'q' must be assigned a value in all cases.
 // Given that 'q' is only ever driven to 0, making 'q' always 0 maintains the functional intent 
 // (q can never be 1) and removes the latch by ensuring a value is assigned unconditionally.
 always @(*) begin
   q = 1'b0; 
 end
endmodule
