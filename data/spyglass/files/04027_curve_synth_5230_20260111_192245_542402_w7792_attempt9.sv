module curve_synth_5230_20260111_192245_542402_w7792_attempt9 (
  input wire [7:0] in_data,
  output reg [31:0] out_data
);

  integer i;
  reg [31:0] accumulated_val; // Will hold the result of the loop's accumulation

  always @(*) begin
    // Initialize 'accumulated_val' to prevent latch inference in this combinational block.
    accumulated_val = 0;

    // SYNTH_5230: This for-loop is designed to trigger the violation.
    // It iterates 2049 times (i from 0 to 2048), which exceeds the default
    // maximum allowable limit of 2048 iterations for synthesis tools like SpyGlass.
    for (i = 0; i < 2049; i = i + 1) begin
      // Perform a simple accumulation. This creates a long chain of adders
      // if unrolled, causing synthesis tools to hit the iteration limit.
      // This form avoids 'W415a' (multiple drivers) for 'accumulated_val'
      // as it represents a single logical computation (an accumulator).
      accumulated_val = accumulated_val + in_data;
    end

    // Assign the final computed value to the output.
    // 'out_data' is assigned only once in this always block to avoid 'W415a'.
    out_data = accumulated_val;
  end

endmodule
