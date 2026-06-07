module verilator_constraintign_9_child_1;
  reg [31:0] r_value; // Represents the 'r' variable from the original SystemVerilog class

  initial begin
    // The original design used SystemVerilog randomization with a 'dist' constraint.
    // Verilator warns (CONSTRAINTIGN) that it ignores complex randomization constraints,
    // effectively making 'r' a truly random 32-bit signed integer.
    // This Verilog code replicates that specific outcome by assigning a standard Verilog $random value,
    // which typically generates a 32-bit signed integer, thus preserving the *functional outcome*
    // of the ignored constraint.
    r_value = $random;
    $display("Random value of r (simulating ignored constraint): %d", r_value);
  end
endmodule
