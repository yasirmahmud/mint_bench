module curve_w337_20260111_194833_042150_w7792_attempt7 (
  input [1:0] sel,
  output reg  out_val
);

  always @* begin
    // Default assignment to prevent latch inference if not all cases are explicitly covered
    out_val = 1'b0;

    case (sel)
      2'b00: out_val = 1'b0;
      2'b01: out_val = 1'b1;
      // W337 violation: Using 'x' in a regular 'case' item is illegal.
      2'b1x: out_val = 1'b0;
      2'b11: out_val = 1'b1;
      // No 'default' is explicitly needed as out_val is initialized, 
      // and 2'b10 will effectively be covered by the initial assignment if 2'b1x doesn't match.
    endcase
  end

endmodule
