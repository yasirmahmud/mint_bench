module incomp_if1(i0, i1, y);
  input i0;
  input i1;
  output reg y; // y needs to be declared as reg for behavioral modeling

  // Implement a D-latch: y passes i1 when i0 is high, otherwise y holds its value.
  always @(i0 or i1) begin
    if (i0) begin
      y <= i1; // When enable (i0) is active, y follows i1
    end else begin
      y <= y; // Explicitly holds its value when i0 is not active (latch behavior)
    end
  end
endmodule
