module top;
  reg [31:0] y_val;

  initial begin
    // In the original design, a SystemVerilog class was used to randomize an integer 'y'.
    // SpyGlass reported 'ELAB_6312: Unsupported SV constructs 'non-virtual class declaration''.
    // To resolve this, the SystemVerilog class and randomization constructs have been removed.
    // The behavior of generating a random integer is preserved using a standard Verilog $urandom function.
    // This also aligns with the mitigation strategy suggested in the design description:
    // "simplify randomization logic, pre-calculate constrained values procedurally".
    // The 'NoTopDUFound' error is also resolved as the module is now fully parseable.
    y_val = $urandom(); // Generate a random 32-bit integer
    $display("Generated random value for y: %0d", y_val);
  end
endmodule
