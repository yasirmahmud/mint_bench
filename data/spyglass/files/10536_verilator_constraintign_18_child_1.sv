module top;
  initial begin
    integer aa; // This variable simulates the 'rand int aa' from the class

    // Simulate the randomization process and the constraint 'aa != 13'
    // $urandom generates a 32-bit unsigned random number.
    // The do-while loop ensures 'aa' is never 13, functionally equivalent
    // to the SystemVerilog constraint.
    do begin
      aa = $urandom();
    end while (aa == 13);

    // The original design did not use 'aa' after randomization,
    // so no further actions are needed here to preserve behavior.
  end
endmodule
