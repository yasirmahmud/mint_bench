module curve_w398_20260111_203005_128651_w36056_attempt10 (
  input [3:0] data_in,
  output reg  data_out
);

  always @(*) begin
    data_out = 1'b0; // Default assignment to avoid latch

    casex (data_in)
      4'b1x1x: data_out = 1'b1; // Covers 4'b1010, 4'b1011, 4'b1110, 4'b1111
      4'bx1x1: data_out = 1'b0; // Covers 4'b0101, 4'b0111, 4'b1101, 4'b1111
      // The value 4'b1111 is covered by both 4'b1x1x and 4'bx1x1
      default: data_out = 1'b0;
    endcase
  end

endmodule
