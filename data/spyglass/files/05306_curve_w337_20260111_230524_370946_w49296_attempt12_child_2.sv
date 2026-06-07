module curve_w337_20260111_230524_370946_w49296_attempt12 (
  input  [1:0] sel_in,
  output reg    out_val
);

  always @(*) begin
    out_val = 1'b0; // Initialize output to prevent latches

    casex (sel_in) // Changed from 'case' to 'casex' to allow 'x' in case item
      2'b00: out_val = 1'b0;
      2'b01: out_val = 1'b1;
      // W337 violation resolved by using 'casex'. '2'bx1' is now legal and treated as a don't care.
      2'bx1: out_val = 1'b0; 
      2'b10: out_val = 1'b1;
      // Include a default to ensure full case coverage and avoid unintended latches.
      default: out_val = 1'b0;
    endcase // Changed from 'endcasex' to 'endcase' to fix syntax violation
  end

endmodule
