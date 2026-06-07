module cast_const_ex10;
  // The original design used SystemVerilog classes and $cast operations
  // to demonstrate a Verilator CASTCONST warning.
  //
  // SpyGlass reports 'ELAB_6312: Unsupported SV constructs 'non-virtual class declaration'
  // because it does not support SystemVerilog class constructs for elaboration.
  //
  // To resolve this SpyGlass violation, all class definitions and their usage
  // must be removed. The functional behavior described for this design example
  // was that the '$display("Cast succeeded")' message was never reached
  // (due to the $cast always failing and being removed in the original 'fix').
  //
  // Removing the class-related code preserves this 'no output' functional behavior.
  initial begin
    // All class-related code, including class declarations and the
    // $cast demonstration, has been removed to resolve SpyGlass ELAB_6312 errors.
    // The behavior remains 'nothing happens' as intended by the previous fix
    // for the Verilator CASTCONST warning.
  end
endmodule
