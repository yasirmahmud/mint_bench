module curve_w398_20260111_203005_128651_w36056_attempt9 (
  input [2:0] in_val,
  output reg  out_val
);

  always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latch
    casex (in_val)
      3'b1x0:  out_val = 1'b1; // Covers 3'b100, 3'b110
      3'bx10:  out_val = 1'b0; // Covers 3'b010, 3'b110
      // The value 3'b110 is covered by both 3'b1x0 and 3'bx10
      default: out_val = 1'b0;
    endcase
  end

endmodule
