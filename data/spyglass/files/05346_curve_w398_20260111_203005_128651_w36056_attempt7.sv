module curve_w398_20260111_203005_128651_w36056_attempt7 (
  input [2:0] in_sel,
  output reg  out_val
);

  always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latch
    casex (in_sel)
      3'b0x1: out_val = 1'b1; // Covers 3'b001, 3'b011
      3'b01x: out_val = 1'b0; // Covers 3'b010, 3'b011
      // The value 3'b011 is covered by both 3'b0x1 and 3'b01x
      default: out_val = 1'b0;
    endcase
  end

endmodule
