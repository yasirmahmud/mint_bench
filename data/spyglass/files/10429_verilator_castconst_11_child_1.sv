module cast_const_ex11;
  class Shape;
    // Adding a member and constructor for robustness against picky linters
    int shape_id = 0;
    function new();
      this.shape_id = 1;
    endfunction
    virtual function void print_info();
      $display("This is a Shape (ID: %0d)", shape_id);
    endfunction
  endclass
  class Circle extends Shape;
    int radius = 0;
    function new();
      super.new();
      this.radius = 10;
      this.shape_id = 2; // Override shape_id for Circle
    endfunction
    virtual function void print_info();
      $display("This is a Circle (Radius: %0d, ID: %0d)", radius, shape_id);
    endfunction
  endclass
  initial begin
    Shape s_obj = new(); // s_obj is a Shape object.
    Circle c_ref;

    // Original: $cast(c_ref, s_obj); // Always fails
    // Verilator warning CASTCONST states: "If it will always fail, the $cast is logically flawed or represents dead code, signaling a potential design error."
    // "Address this by ... re-evaluating and correcting the logic for always-failing $casts."
    // Since s_obj is instantiated as a 'Shape' object and not a 'Circle' object (or a class derived from 'Circle'),
    // the dynamic $cast(c_ref, s_obj) will always fail. As its failure was not explicitly handled or checked,
    // it represents dead code or a logical flaw as per the warning description.
    // Removing this always-failing $cast operation: 
    // 1. Resolves the Verilator CASTCONST warning.
    // 2. Preserves the functional behavior where c_ref remains null (as it would after a failed cast).
    // 3. Preserves the `$display("Cast attempted.");` output, as it occurs regardless of the cast's success or failure.

    // SpyGlass errors ELAB_6312 ("Unsupported SV constructs 'non-virtual class declaration'") and NoTopDUFound
    // often indicate the linter struggles with basic SystemVerilog class parsing, especially with empty class definitions.
    // Adding explicit members, constructors, and virtual methods to Shape and Circle classes is a common heuristic
    // to make them more robustly parsed by strict or older linting tools. This should help resolve ELAB_6312, 
    // which in turn allows the module to be recognized, resolving NoTopDUFound.

    $display("Cast attempted.");
  end
endmodule
