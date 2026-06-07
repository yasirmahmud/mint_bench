module curve_w398_20260111_203005_128651_w36056_attempt6 (
  input [1:0] in_sel,
  output reg  out_val
);

  always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latch
    casez (in_sel)
      2'b0z: out_val = 1'b1; // Matches 2'b00, 2'b01
      2'bz0: out_val = 1'b0; // Matches 2'b00, 2'b10
      // The value 2'b00 is covered by both 2'b0z and 2'bz0
      default: out_val = 1'b0;
    endcase
  end

endmodule
