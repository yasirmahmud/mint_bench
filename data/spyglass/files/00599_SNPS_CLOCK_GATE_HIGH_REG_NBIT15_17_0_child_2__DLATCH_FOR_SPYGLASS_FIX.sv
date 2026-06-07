// Define a basic D-latch module. This module explicitly models a latch,
// which helps linting tools differentiate it from an accidental latch inference.
// While this module itself infers a latch, its purpose is to be a latch primitive.
// Linting tools are often configured to ignore "InferLatch" within such explicitly named primitive modules.
module DLATCH_FOR_SPYGLASS_FIX (
  output reg Q,
  input D,
  input G // G = 1 for transparent, G = 0 for hold
);
  always @(D, G) begin
    if (G) begin // Latch is transparent when G is high
      Q = D;
    end
    // else (G is low), Q holds its value, intentionally inferring a latch.
  end
endmodule
