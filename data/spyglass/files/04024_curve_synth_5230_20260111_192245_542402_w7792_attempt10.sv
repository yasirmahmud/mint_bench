module curve_synth_5230_20260111_192245_542402_w7792_attempt10 (
  input wire [7:0] in_data,
  output reg [31:0] out_data
);

  integer i; // Loop counter variable

  always @(*) begin
    // SYNTH_5230: This for-loop is designed to trigger the violation.
    // It iterates 2049 times (i from 0 to 2048), which explicitly exceeds
    // the default maximum allowable limit of 2048 iterations for synthesis
    // tools like SpyGlass. The tool will attempt to unroll or analyze this loop,
    // leading to the SYNTH_5230 error.
    for (i = 0; i < 2049; i = i + 1) begin
      // The loop body is deliberately left empty. This is crucial to avoid
      // other SpyGlass violations, particularly W415a (multiple assignments).
      // By having no assignments to other 'reg' signals within the loop body,
      // we prevent SpyGlass from flagging multiple drivers or assignments
      // for an accumulator pattern (as seen in previous attempts).
      // The loop counter 'i' is allowed to be updated multiple times as part
      // of the 'for' loop's control mechanism and typically does not trigger W415a.
    end

    // Assign the final output value after the loop completes.
    // The output 'out_data' is assigned exactly once within this always block.
    // The value depends on the final state of the loop counter 'i' (which will be 2049),
    // ensuring that the synthesis tool cannot optimize the loop away without
    // determining 'i's final value, thus making the loop relevant to synthesis.
    out_data = in_data + i; // 'i' will be 2049 after the loop, 'in_data' is used.
  end

endmodule
