module top;
  // MyClass and randomization constructs are removed as they are unsupported
  // by SpyGlass/Verilator for linting and cause ELAB_6312. This resolves
  // the "Unsupported SV constructs 'non-virtual class declaration'" error.
  // It also implicitly resolves "No top design unit has been found" by
  // providing a valid top-level module with recognized constructs.
  //
  // The functionality of randomizing 'w' to be less than 20 is re-implemented
  // using procedural Verilog, as suggested by the Verilator warning description
  // ("pre-calculate constrained values procedurally").

  // Declare 'w_val' as a signed integer, matching the 'rand int w' type.
  reg signed [31:0] w_val;

  initial begin
    // Simulate the behavior of obj.randomize() with constraint c_w { w < 20; };
    // To simplify and allow procedural calculation, we assume a practical
    // lower bound, e.g., 0, resulting in 0 <= w < 20. This is a common
    // interpretation when converting open-ended constraints to procedural logic
    // in an RTL context, aligning with the suggestion to "simplify randomization logic".
    // $urandom_range(min, max) generates a value between min and max inclusive.
    // So, for 0 <= w_val < 20, we use $urandom_range(0, 19).
    w_val = $urandom_range(0, 19);
    $display("Randomized w_val: %0d", w_val);
  end
endmodule
