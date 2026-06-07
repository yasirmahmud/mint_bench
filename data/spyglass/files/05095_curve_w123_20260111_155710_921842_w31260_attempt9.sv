module curve_w123_20260111_155710_921842_w31260_attempt9 (
  input wire in_a,
  output wire out_b
);

  // Declare 'Q' as an extremely large wire (1,048,576 bits wide).
  // This size is intended to be definitively "too big" for default processing
  // by SpyGlass, triggering the W123 rule.
  wire [1048575:0] Q; // Corresponds to [2^20-1:0]

  // Drive a single bit of 'Q' to ensure the bus is considered used and not optimized away.
  // This minimizes logic while keeping the large bus declared.
  assign Q[0] = in_a;

  // Access the specific bit 'Q[1823]' mentioned in the rule description.
  // This direct access within the extremely large bus is expected to be the trigger
  // for the W123 violation, as the tool attempts to process this bit but may fail
  // due to the overall size of 'Q' without the 'handle_large_bus' parameter.
  assign out_b = Q[1823];

endmodule
