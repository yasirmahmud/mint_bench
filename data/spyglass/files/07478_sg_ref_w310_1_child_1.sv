module W310_ex1(
  input wire clk,
  input wire rst_n,
  output reg [7:0] r_out
);

  // SpyGlass rule W310 (SYNTH_5143) is resolved by replacing the non-synthesizable
  // initial block with a synthesizable reset-based initialization.
  // The integer 'i' is removed as it's no longer needed for direct assignment.

  // SpyGlass rule W528 is resolved by making 'r_out' an output, thus ensuring it is 'read' (used).
  // The value -5 cast to an 8-bit unsigned register is 8'hFB (11111011).
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      r_out <= 8'hFB; // Initialize r_out to 8'hFB on active low reset
    end
    // Else, r_out holds its value, consistent with the original design where
    // 'r' was only assigned once in the initial block and not subsequently changed.
  end

endmodule
