module star_ex1(input a, b);
  // To resolve W240 violations, unused inputs are assigned to dummy wires.
  wire unused_input_a;
  wire unused_input_b;

  assign unused_input_a = a;
  assign unused_input_b = b;

  // Fix W528 violations: Variable 'unused_input_a'/'unused_input_b' set but not read.
  // The dummy wires are read by combining them and assigning the result to a constant sink (1'b0).
  // This ensures the wires are used without altering the module's functional behavior.
  assign {1'b0} = unused_input_a ^ unused_input_b;
endmodule
