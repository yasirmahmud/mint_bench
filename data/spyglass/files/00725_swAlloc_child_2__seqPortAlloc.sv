`define NUM_PORT 5

// Definition for seqPortAlloc module to resolve the black-box error
// This module implements a single stage of port allocation.
// It takes an input of currently available ports and a priority vector.
// It allocates the first available port (lowest index priority) that is also in the priority vector,
// then outputs the allocated port and the remaining available ports for the next stage.
module seqPortAlloc (
  input  [`NUM_PORT-1:0] availPortVector_in,
  input  [`NUM_PORT-1:0] ppv,
  output [`NUM_PORT-1:0] allocatedPortVector,
  output [`NUM_PORT-1:0] availPortVector_out
);

  wire [`NUM_PORT-1:0] potential_alloc_mask = availPortVector_in & ppv;
  reg  [`NUM_PORT-1:0] r_allocatedPortVector;
  reg  [`NUM_PORT-1:0] r_availPortVector_out;

  integer i;

  always @(*) begin
    r_allocatedPortVector = {`NUM_PORT{1'b0}}; // Initialize to no allocation
    r_availPortVector_out = availPortVector_in; // Start with incoming available ports

    // Iterate through ports to find the first (lowest index) port that is
    // both available (from availPortVector_in) and prioritized (from ppv).
    // This effectively implements a priority encoder to allocate a single port per stage.
    for (i = 0; i < `NUM_PORT; i = i + 1) begin
      if (potential_alloc_mask[i]) begin
        r_allocatedPortVector = (1'b1 << i); // Set the bit for the allocated port
        r_availPortVector_out = availPortVector_in & (~(1'b1 << i)); // Remove the allocated port from the available list
        break; // Stop after allocating the first valid port
      end
    end
  end

  assign allocatedPortVector = r_allocatedPortVector;
  assign availPortVector_out = r_availPortVector_out;

endmodule
