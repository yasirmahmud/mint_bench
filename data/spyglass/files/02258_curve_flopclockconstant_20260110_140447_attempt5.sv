module curve_flopclockconstant_20260110_140447_attempt5 (
  input d1,
  input d2,
  output reg q1,
  output reg q2
);

  // First flop with a constant clock
  wire constant_low_clock_wire1;
  assign constant_low_clock_wire1 = 1'b0;
  
  always @(posedge constant_low_clock_wire1) begin
    q1 <= d1;
  end

  // Second flop with another constant clock
  wire constant_low_clock_wire2;
  assign constant_low_clock_wire2 = 1'b0;

  always @(posedge constant_low_clock_wire2) begin
    q2 <= d2;
  end

endmodule
