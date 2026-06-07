module curve_w398_attempt11 (
  input [2:0] in_val,
  output reg out_val
);

  always @* begin
    out_val = 1'b0; // Default assignment to prevent latches
    casex (in_val)
      3'b1x1:  out_val = 1'b1; // Covers 3'b101, 3'b111
      3'bx01: out_val = 1'b0; // Covers 3'b001, 3'b101
      // The value 3'b101 is covered by both 3'b1x1 and 3'bx01
      default: out_val = 1'b0;
    endcase
  end

endmodule
