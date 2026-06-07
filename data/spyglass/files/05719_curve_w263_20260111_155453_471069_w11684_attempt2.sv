module curve_w263_20260111_155453_471069_w11684_attempt2 (
    input wire [1:0] state_selector, // 2-bit selector
    output reg       output_data
);

  // W263: Case label width does not match selector width.
  // The selector 'state_selector' is 2 bits wide.
  // The case label '1'b1' is 1 bit wide.
  always @* begin
    output_data = 1'b0; // Default assignment to avoid latch generation
    case (state_selector)
      2'b00: begin
        output_data = 1'b0;
      end
      1'b1: begin // This case label (1-bit) mismatches the selector (2-bit) -> W263 violation
        output_data = 1'b1;
      end
      2'b10: begin
        output_data = 1'b0;
      end
      default: begin
        output_data = 1'b0;
      end
    endcase
  end

endmodule
