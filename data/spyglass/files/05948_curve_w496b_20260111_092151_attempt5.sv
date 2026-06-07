module curve_w496b_20260111_092151_attempt5 (
  input       [1:0] select_bits, // 2-bit input selector
  output reg        data_out     // 1-bit output register
);

  // This always block describes combinational logic.
  always @(*) begin
    // Default assignment to ensure combinational logic and prevent unintended latches.
    data_out = 1'b0;

    // The 'case' statement is used here. A standard 'case' performs an exact
    // bit-for-bit comparison between the case expression and each case item.
    // Unlike 'casex' or 'casez', 'x' and 'z' values in case items are treated
    // as literal match conditions, not as don't-cares.
    //
    // Rule W496b triggers when a case item contains a tristate value ('?').
    // Synthesis tools often interpret such a comparison as a condition that will
    // always evaluate to 'false', especially if the input 'select_bits' is
    // expected to carry only '0' or '1' values. This effectively renders the
    // associated code branch unreachable in the synthesized netlist.
    case (select_bits)
      2'b00: data_out = 1'b0; // A regular case item
      2'b10: data_out = 1'b1; // Another regular case item
      
      // This line is the specific trigger for W496b.
      // The case item '2'b?1' contains a tristate '?' (which is equivalent to 'z').
      // In a standard 'case' comparison, this is treated as always false by synthesis,
      // making the assignment 'data_out = 1'b1;' unreachable.
      2'b?1: data_out = 1'b1; 
      
      // A 'default' case covers all other combinations, including potential
      // 'x' or 'z' values in 'select_bits' that do not match the explicit items.
      default: data_out = 1'b0;
    endcase
  end

endmodule
