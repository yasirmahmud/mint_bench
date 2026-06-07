module top (
  output reg [31:0] x = 32'h0 // Declare 'x' as an output register and initialize it to 0.
                              // This resolves SYNTH_5143 by removing the non-synthesizable initial block.
                              // It also resolves W528 by making 'x' an observable output.
);
