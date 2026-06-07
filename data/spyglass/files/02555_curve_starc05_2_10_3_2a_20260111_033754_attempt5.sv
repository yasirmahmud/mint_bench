module curve_starc05_2_10_3_2a_20260111_033754_attempt5 (
  input wire request_valid,   // 1 bit
  input wire [4:0] address_val,  // 5 bits
  input wire control_signal,    // Used to ensure full assignment in combinational logic
  output reg grant_access      // Output is a reg for always @*
);

  // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'.
  // This rule specifically targets the bit-width mismatch for logical AND.
  // 'request_valid' has a width of 1 bit.
  // 'address_val' has a width of 5 bits.
  // The widths (1 and 5) are different, triggering STARC05-2.10.3.2a.
  // This example places the violation within a combinational always block
  // and uses an if-else structure to differentiate from direct 'assign' statements
  // used in previous attempts, while maintaining a minimal and clean structure.
  // It's challenging to avoid STARC05-2.1.4.5, which often co-triggers 
  // when '&&' operates on multi-bit operands, as seen in the context examples.

  always @(*) begin
    if (control_signal) begin
      grant_access = 1'b0; // Blocking assignment for combinational logic
    end else begin
      // This line is expected to trigger STARC05-2.10.3.2a
      // 'request_valid' (1-bit) && 'address_val' (5-bit)
      grant_access = request_valid && address_val;
    end
  end

endmodule
