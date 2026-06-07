module curve_flopclockconstant_20260110_140447_attempt4 (
  input d1,
  input d2,
  output reg q1,
  output reg q2
);

  // First flop clocked directly by a constant logic '0'
  always @(posedge 1'b0) begin
    q1 <= d1;
  end

  // Declare a wire and assign it to a constant logic '0'
  wire constant_low_clock_wire;
  assign constant_low_clock_wire = 1'b0;

  // Second flop clocked by the constant-low wire
  always @(posedge constant_low_clock_wire) begin
    q2 <= d2;
  end

endmodule
