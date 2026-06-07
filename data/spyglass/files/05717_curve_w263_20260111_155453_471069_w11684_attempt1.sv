module curve_w263_20260111_155453_471069_w11684_attempt1 (
    input wire [2:0] selector_in,
    output reg       output_val
);

  // W263: Case label width does not match selector width.
  // The selector 'selector_in' is 3 bits wide.
  // The case label '1'b1' is 1 bit wide.
  always @* begin
    output_val = 1'b0; // Default assignment to avoid latch generation
    case (selector_in)
      3'b000: begin
        output_val = 1'b0;
      end
      1'b1: begin // This case label (1-bit) mismatches the selector (3-bit) -> W263 violation
        output_val = 1'b1;
      end
      3'b010: begin
        output_val = 1'b0;
      end
      default: begin
        output_val = 1'b0;
      end
    endcase
  end

endmodule
