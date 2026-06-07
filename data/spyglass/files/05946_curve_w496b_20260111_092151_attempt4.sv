module curve_w496b_20260111_092151_attempt4 (
  input       [1:0] data_in, // 2-bit input signal
  output reg        out_val  // 1-bit output register
);

  always @(*) begin
    // Default assignment to prevent inferred latches in combinational logic.
    out_val = 1'b0;

    // This 'case' statement is designed to trigger the W496b violation.
    // In Verilog-2001, '?' is a shorthand for 'z' (high-impedance).
    // A standard 'case' statement performs a bit-for-bit comparison, meaning
    // 'x' and 'z' values in the case items are treated as literal match conditions,
    // unlike 'casez' or 'casex' where 'z' or 'x' act as don't-cares.
    //
    // Rule W496b specifically targets this scenario: a 'case' item with a
    // tristate value (like '2'b1?') is often treated by synthesis tools as a
    // condition that will always evaluate to 'false'. This renders the associated
    // code branch unreachable in the synthesized netlist.
    case (data_in)
      2'b00: out_val = 1'b0;
      2'b01: out_val = 1'b1;
      
      // This line is the specific trigger for W496b.
      // The comparison for '2'b1?' is treated as false in synthesis, effectively
      // making this branch dead code, as described by the rule.
      2'b1?: out_val = 1'b0;
      
      // A 'default' case is included to ensure all possible 2-bit input
      // combinations (including 'x' and other 'z' values for 'data_in' that
      // do not explicitly match above) are covered, preventing latches and
      // ensuring a complete combinational assignment.
      default: out_val = 1'b0;
    endcase
  end

endmodule
