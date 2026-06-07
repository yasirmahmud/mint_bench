module PEend (
  clock,
  R,
  S1,
  S2,
  S1S2mux,
  newDist,
  Accumulate
);
  input clock;
  input [7:0] R, S1, S2; // memory inputs
  input S1S2mux, newDist; // control input
  output [7:0] Accumulate;
  reg [7:0] Accumulate; // Current accumulated value
  reg [7:0] AccumulateIn; // Next value for Accumulate

  // Sequential block: Update Accumulate on positive clock edge
  always @(posedge clock) Accumulate <= AccumulateIn;

  // Combinational block: Calculate AccumulateIn based on inputs and current Accumulate
  always @* begin
    reg [7:0] selected_S;
    reg [7:0] abs_difference;
    reg [8:0] sum_for_saturation; // Use a wider register to detect carry/overflow

    // Step 1: Select S1 or S2 based on S1S2mux
    selected_S = S1S2mux ? S1 : S2;

    // Step 2: Calculate the absolute difference between R and selected_S
    // This correctly handles unsigned 8-bit values.
    if (R >= selected_S) begin
      abs_difference = R - selected_S;
    end else begin
      abs_difference = selected_S - R;
    end

    // Step 3: Determine the next accumulator value (AccumulateIn)
    // The 'newDist' signal has priority for resetting the accumulator.
    if (newDist == 1) begin
      AccumulateIn = abs_difference; // Reset accumulator to the new difference
    end else begin
      // Accumulate the current value with the new absolute difference
      // and apply saturation if an overflow occurs.
      sum_for_saturation = Accumulate + abs_difference;

      // Check for overflow (carry-out from the 8-bit sum)
      if (sum_for_saturation[8] == 1) begin
        AccumulateIn = 8'hFF; // Saturate to the maximum 8-bit value (255)
      end else begin
        AccumulateIn = sum_for_saturation[7:0]; // No overflow, use the sum
      end
    end
  end
endmodule
