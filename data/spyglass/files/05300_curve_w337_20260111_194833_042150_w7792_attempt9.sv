module curve_w337_20260111_194833_042150_w7792_attempt9 (
  input [1:0] sel_in,
  output reg out_val
);

  always @* begin
    out_val = 1'b0; // Default assignment to prevent latch inference

    // W337 violation: Using 'z' (high-impedance) in a regular 'case' item is illegal in Verilog-2001.
    // Standard 'case' performs a bit-for-bit comparison. A 'z' in a case item
    // means the specific bit must be 'z' to match. This is typically only
    // relevant for 'casez' or 'casex' where 'z' or 'x' act as don't cares.
    // For a standard 'case' statement, 'z' (like 'x') is treated as a specific
    // state, which is generally not intended for case items, hence flagged as an
    // "illegal value".
    //
    // Using an input 'sel_in' directly as the case expression makes it
    // plausible for 'sel_in' to conceptually contain 'z' values (e.g., from
    // undriven signals or tri-state buffers upstream, though synthesis often
    // assumes inputs are '0' or '1'). This approach is chosen to minimize
    // other warnings like SYNTH_5034 ("Comparison with don't care or tristate will be always false")
    // by allowing the comparison to potentially be true if 'sel_in' happens to be '2'b1z'.
    case (sel_in)
      2'b00: out_val = 1'b0;
      2'b01: out_val = 1'b1;
      // This 'z' in a standard 'case' item triggers W337.
      2'b1z: out_val = 1'b0;
      default: out_val = 1'b0;
    endcase
  end

endmodule
