module LatchFeedback_ex2 (input en, output q_out);
  reg q1, q2;

  // To break the combinational loop for the swap operation between latches,
  // one of the values (e.g., q1) needs to be temporarily captured at the start
  // of the enable pulse, so it reflects its 'stable, current output' value
  // before the latches become transparent and potentially change.
  // This introduces a temporary flip-flop (edge-triggered by 'en') to store q1's value.
  reg q1_captured;
  always @(posedge en) begin
    q1_captured <= q1; // Capture q1's value at the rising edge of 'en'
  end

  // Explicit latch for q1
  // When 'en' is high, q1 loads 'q2'.
  // When 'en' is low, q1 holds its current value.
  always @* begin
    if (en) begin
      q1 = q2; // q1 gets the current value of q2
    end else begin
      q1 = q1;
    end
  end

  // Explicit latch for q2
  // When 'en' is high, q2 loads 'q1_captured' (the value of q1 sampled
  // at the positive edge of 'en', before q1 itself changed due to transparency).
  // When 'en' is low, q2 holds its current value.
  always @* begin
    if (en) begin
      q2 = q1_captured;
    end else begin
      q2 = q2;
    end
  end

  assign q_out = q1;
endmodule
