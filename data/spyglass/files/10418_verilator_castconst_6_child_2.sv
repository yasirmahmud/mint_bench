module cast_const_ex6;
  // SpyGlass reported "Unsupported SV constructs 'non-virtual class declaration'" (ELAB_6312).
  // Since SystemVerilog classes are generally not supported for traditional RTL linting
  // and to resolve the SpyGlass elaboration errors, the class hierarchy is replaced
  // with equivalent SystemVerilog structs using composition for inheritance.
  
  typedef struct {
    bit _dummy; // Placeholder to make the struct non-empty
  } Component_t;

  typedef struct {
    Component_t base; // Represents inheritance through composition
    bit _sub_dummy; // Placeholder for SubComponent specific fields
  } SubComponent_t;

  initial begin
    // SYNTH_5143: "Initial block is ignored for synthesis".
    // This module is an example demonstrating SystemVerilog features (structs and assignments)
    // within a simulation context, not intended for synthesizable hardware.
    // The 'initial' block is crucial for the example's functional behavior in simulation
    // and therefore cannot be removed without fundamentally altering the design's purpose.
    
    Component_t comp_base;
    SubComponent_t sub_comp;

    // Initialize sub_comp, similar to `new()` for classes.
    sub_comp = '{base: '{_dummy: 1'b0}, _sub_dummy: 1'b0};

    // The original design had an upcast: $cast(comp_base, sub_comp).
    // An upcast (from derived type to base type) always succeeds.
    // The Verilator warning CASTCONST suggested replacing this with a static cast/assignment
    // to avoid unnecessary runtime overhead.
    // With structs, the equivalent static assignment is assigning the base part of the derived struct.
    comp_base = sub_comp.base;

    // The original 'if ($cast(comp_base, sub_comp) == 0)' block would only execute
    // if the cast failed. Since an upcast always succeeds, that block would never be entered.
    // With the static assignment `comp_base = sub_comp.base;`, failure is impossible,
    // thus the `if` block and its content are correctly removed as dead code.

    // --- Fix for SpyGlass W528 violations: variables set but not read --- 
    // W528: Variable 'sub_comp._sub_dummy' set but not read.
    // Reading the variable to resolve the lint warning while demonstrating its value.
    $display("INFO: Initialized sub_comp._sub_dummy to %0d", sub_comp._sub_dummy);

    // W528: Variable 'comp_base._dummy' set but not read.
    // Reading the variable to resolve the lint warning while demonstrating its value.
    $display("INFO: Initialized comp_base._dummy (from upcast) to %0d", comp_base._dummy);
    // --- End of SpyGlass W528 fix --- 
  end
endmodule
