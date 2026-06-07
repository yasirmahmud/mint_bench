module star_ex1(input a, b);
  // To resolve W240 violations, unused inputs are assigned to dummy wires.
  wire unused_input_a;
  wire unused_input_b;

  assign unused_input_a = a;
  assign unused_input_b = b;
endmodule
