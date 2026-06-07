module curve_w398_attempt12 (
  input [3:0] data_in,
  output reg out_val
);

  always @* begin
    out_val = 1'b0; // Default assignment to prevent latches
    casex (data_in)
      4'b0x1x: out_val = 1'b1; // Covers 4'b0010, 4'b0011, 4'b0110, 4'b0111
      4'bx1x0: out_val = 1'b0; // Covers 4'b0100, 4'b0110, 4'b1100, 4'b1110
      // The value 4'b0110 is covered by both 4'b0x1x and 4'bx1x0
      default: out_val = 1'b0;
    endcase
  end

endmodule
