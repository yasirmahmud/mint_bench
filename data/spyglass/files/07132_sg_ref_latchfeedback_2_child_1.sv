module LatchFeedback_ex2 (input en, output q_out);
  reg q1, q2;
  wire next_q1, next_q2;

  // Define the data inputs for the latches to break the direct feedback loop.
  // This ensures that the values used for the swap (q1 and q2 on the RHS)
  // are the stable, current outputs of the latches, not values in flux.
  assign next_q1 = q2;
  assign next_q2 = q1;

  // Explicit latch for q1
  // When 'en' is high, q1 loads 'next_q1'.
  // When 'en' is low, q1 holds its current value.
  always @* begin
    if (en) begin
      q1 = next_q1;
    end else begin
      q1 = q1;
    end
  end

  // Explicit latch for q2
  // When 'en' is high, q2 loads 'next_q2'.
  // When 'en' is low, q2 holds its current value.
  always @* begin
    if (en) begin
      q2 = next_q2;
    end else begin
      q2 = q2;
    end
  end

  assign q_out = q1;
endmodule
