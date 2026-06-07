module verilator_constraintign_7_child_1;
  // Original intent: 'rand int p; constraint c7 { p % 2 == 0; };'
  // Verilator and some linting tools do not support SystemVerilog classes and randomization directly.
  // To maintain functional behavior (p is a random even integer) and resolve violations,
  // we simulate the randomization procedurally using Verilog's $random.

  int p; // Declare 'p' as an integer directly in the module

  initial begin
    // Generate a random even integer for 'p'.
    // $random returns a signed 32-bit integer.
    // Bitwise ANDing with ~1 (which is ...1110) clears the LSB, ensuring 'p' is even.
    p = $random & ~1;

    // Optional: display the result for verification
    $display("Random even number p = %0d", p);
  end

endmodule
