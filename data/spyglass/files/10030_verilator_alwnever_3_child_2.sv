module example_3 (output reg [3:0] count = 4'd0);
  // The 'initial' block is ignored for synthesis (SYNTH_5143).
  // To resolve this and preserve the functional behavior of initializing 'count' to 0,
  // the 'count' register is initialized directly in its declaration. 
  // This provides a synthesizable power-on reset equivalent.
endmodule
