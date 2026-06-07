module curve_w398_20260111_203005_128651_w36056_attempt8 (
  input [3:0] in_sel,
  output reg  out_val
);

  always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latch
    casex (in_sel)
      4'b1x0x: out_val = 1'b1; // Covers 4'b1000, 4'b1001, 4'b1100, 4'b1101
      4'b10x1: out_val = 1'b0; // Covers 4'b1001, 4'b1011
      // The value 4'b1001 is covered by both 4'b1x0x and 4'b10x1
      default: out_val = 1'b0;
    endcase
  end

endmodule
