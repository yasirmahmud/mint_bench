module sub_mod (input a);
  // Resolve W240: Input 'a' declared but not read.
  // By assigning it to an internal wire, we acknowledge its presence without
  // introducing new functional behavior.
  wire unused_input_a;
  assign unused_input_a = a;
endmodule
