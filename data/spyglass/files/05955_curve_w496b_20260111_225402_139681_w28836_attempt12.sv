module curve_w496b_20260111_225402_139681_w28836_attempt12 (
  input  [3:0] data_in,
  output reg    output_valid
);

  // This always block describes combinational logic.
  always @* begin
    output_valid = 1'b0; // Default assignment to avoid latches

    // Using a 'case' statement where the selector 'data_in' is expected to contain valid 0/1 combinations.
    case (data_in)
      4'b0000: output_valid = 1'b0;
      4'b0001: output_valid = 1'b1;
      4'b0010: output_valid = 1'b0;
      4'b0011: output_valid = 1'b1;
      4'b0100: output_valid = 1'b0;
      4'b0101: output_valid = 1'b1;
      4'b0110: output_valid = 1'b0;
      4'b0111: output_valid = 1'b1;
      4'b1000: output_valid = 1'b0;
      4'b1001: output_valid = 1'b1;
      4'b1010: output_valid = 1'b0;
      // Target Rule W496b: Case comparison of expression: "4'b101?" to tristate value: '1?'
      // is treated as false in synthesis. In standard 'case' statements (not 'casex' or 'casez'),
      // the '?' is interpreted as a literal 'x' (unknown) or 'z' (high-impedance) and not as a wildcard.
      // This means a 'case_item' like '4'b101?' effectively becomes '4'b101x' for matching.
      // If 'data_in' contains only '0's and '1's, '4'b101x' will never match, causing a discrepancy
      // between simulation behavior (where some tools might treat '?' as a wildcard for convenience)
      // and synthesis behavior (where it will never match).
      4'b101?: output_valid = 1'b1; // This line is specifically designed to trigger W496b.
      default: output_valid = 1'b0; // Ensures all possible input combinations (including X/Z for 'data_in') are covered, preventing latches.
    endcase
  end

endmodule
