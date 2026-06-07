module curve_w337_20260111_230524_370946_w49296_attempt11 (
  input  [2:0] sel_in,
  output reg    out_val
);

  always @(*) begin
    // Initialize output to avoid latches if any path is not covered
    out_val = 1'b0; 

    case (sel_in)
      3'b000: out_val = 1'b0;
      3'b001: out_val = 1'b1;
      // W337 violation: Illegal value 'z' used as a case item in a regular 'case' statement.
      3'b01z: out_val = 1'b0; 
      3'b011: out_val = 1'b1;
      3'b100: out_val = 1'b0;
      3'b101: out_val = 1'b1;
      3'b110: out_val = 1'b0;
      3'b111: out_val = 1'b1;
      // A default case ensures all possible input combinations are handled
      // and prevents the inference of a latch, even if 'sel_in' contains 'x' or 'z'.
      default: out_val = 1'b0;
    endcase
  end

endmodule
