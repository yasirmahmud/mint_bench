module cast_const_ex10;
  class Animal;
  endclass
  class Dog extends Animal;
  endclass
  initial begin
    Animal pet = new();
    // The original $cast operation ($cast(my_dog, pet)) would always fail
    // because 'pet' is an object of type 'Animal', not 'Dog' or a subclass of 'Dog'.
    // Verilator would issue a CASTCONST warning here, indicating that the success/failure
    // of this $cast can be determined at compile time.
    //
    // The subsequent 'if (success == 1)' block was therefore unreachable (dead code),
    // as 'success' would always be 0.
    //
    // To resolve this according to the design description ("re-evaluating and correcting
    // the logic for always-failing $casts") while preserving functional behavior
    // (i.e., the "$display("Cast succeeded")" message is never printed),
    // we remove the logically flawed $cast and the associated dead code.
    // No functional change occurs, as the original $display was never reached.
    // Dog my_dog; // Removed as it was only used for the failing $cast
    // int success = $cast(my_dog, pet);
    // if (success == 1) begin // This block is always unreachable
    //   $display("Cast succeeded");
    // end
  end
endmodule
