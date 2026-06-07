module LatchBlockingAssign2 (
  input wire set_latch,
  input wire value_in,
  output reg latched_value
);

  always @* begin
    if (set_latch) begin
      latched_value = value_in; // Latch inferred, blocking assignment
    end
    // No else clause, so latched_value retains its value when set_latch is 0
  end

endmodule
