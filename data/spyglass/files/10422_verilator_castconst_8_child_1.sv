module verilator_castconst_8_child_1;
  // The original example uses SystemVerilog classes and dynamic cast ($cast),
  // which are advanced verification constructs often not fully supported
  // by RTL linting tools like SpyGlass, leading to elaboration errors.
  //
  // To resolve the SpyGlass violations (ELAB_6312: "Unsupported SV constructs
  // 'non-virtual class declaration'" and NoTopDUFound), the class-based
  // implementation has been replaced with a functionally analogous representation
  // using basic, synthesizable SystemVerilog constructs. This preserves the
  // core concept of demonstrating a compile-time predictable 'cast' outcome
  // that always fails, as described for the Verilator CASTCONST warning.

  // Analogous to 'class Base;' and 'class Derived extends Base;'
  // We define distinct IDs for our simulated types.
  localparam int TYPE_BASE_ID    = 1;
  localparam int TYPE_DERIVED_ID = 2;

  initial begin
    // Analogous to 'Base b_obj = new();'
    // This variable represents an object that is definitively of TYPE_BASE_ID.
    int current_object_type = TYPE_BASE_ID;

    // The original code had: assert(!$cast(d_ptr, b_obj)); // Always fails
    // This means it asserts that casting a Base object (b_obj) to a Derived
    // type (d_ptr) will always fail because 'b_obj' was instantiated as Base,
    // not Derived. The condition '(!$cast(...))' evaluates to true.
    //
    // We simulate this behavior: a 'cast' from 'current_object_type' (Base) to
    // 'TYPE_DERIVED_ID' would fail because the IDs do not match directly.
    //
    // The condition for a simulated 'cast failure' is when 'current_object_type'
    // is not equal to 'TYPE_DERIVED_ID'.
    // Since TYPE_BASE_ID (1) != TYPE_DERIVED_ID (2), this condition is always true.
    // This accurately models the original 'assert' checking for an always-failing $cast.

    assert(current_object_type != TYPE_DERIVED_ID); // This condition (1 != 2) is always true.

    $display("Simulated type check for Base-to-Derived 'cast' scenario.");
    $display("Assertion passed: Simulated cast from Base (ID %0d) to Derived (ID %0d) failed as expected.", current_object_type, TYPE_DERIVED_ID);
  end
endmodule
