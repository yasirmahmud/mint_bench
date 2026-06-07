// Child module definition: a simple AND gate
// This module defines two inputs and one output for an AND operation.
module simple_and_gate (
  input wire in1,      // First input
  input wire in2,      // Second input
  output wire out_and  // Output of the AND operation
);

  assign out_and = in1 & in2;

endmodule
