module curve_w337_20260111_230524_370946_w49296_attempt12 (
  input  [1:0] sel_in,
  output reg    out_val
);

  always @(*) begin
    out_val = 1'b0; // Initialize output to prevent latches

    case (sel_in)
      2'b00: out_val = 1'b0;
      2'b01: out_val = 1'b1;
      // W337 violation: Using 'x' in a regular 'case' item is illegal.
      // This line is specifically designed to trigger W337.
      2'bx1: out_val = 1'b0; 
      2'b10: out_val = 1'b1;
      // Include a default to ensure full case coverage and avoid unintended latches.
      default: out_val = 1'b0;
    endcase
  end

endmodule
