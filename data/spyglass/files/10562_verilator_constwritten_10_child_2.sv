module const_write_10;
  // SYNTH_89: The initial assignment `int value = 100;` is ignored by synthesis.
  // To resolve this, we remove the declaration-time initialization. 
  // For synthesizable logic, variables must be driven by continuous assignments or procedural blocks.
  // Declaring as `logic int` allows continuous assignment via `assign`.
  logic int value; 
  
  function automatic int get_value();
    // W424: Functions should not set global variables. 
    // The assignment `value = 200;` has been removed from inside the function.
    // The function now purely returns a value without side effects.
    return 200;
  endfunction

  // To preserve the functional behavior where `value` becomes 200 (as the original
  // function would assign it), we use a continuous assignment.
  // This ensures `value` is always 200, which is the result the function was effectively forcing.
  // The initial `100` is effectively overwritten very early by the original logic,
  // and this simplified continuous assignment captures the dominant functional intent for synthesis.
  assign value = get_value(); 
endmodule
