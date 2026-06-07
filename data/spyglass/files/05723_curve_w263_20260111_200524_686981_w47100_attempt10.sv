module curve_w263_20260111_200524_686981_w47100_attempt10 (
  input wire [3:0] input_data,
  output reg       output_valid
);

  reg [3:0] state_register; // Selector width: 4 bits

  always @(*) begin
    state_register = input_data; // Assign input to selector
    output_valid = 1'b0;        // Default output ensures no latches

    case (state_register) // Selector is 4 bits wide
      4'b0000: begin // Label matches selector width (4 bits)
        output_valid = 1'b0;
      end
      // VIOLATION: This case label (3'd1) has an explicit width of 3 bits,
      // which does not match the selector (state_register) width of 4 bits.
      // This triggers exactly one W263 violation.
      3'd1: begin // Mismatched width (3 bits vs 4 bits) triggers W263
        output_valid = 1'b1;
      end
      4'b0010: begin // Label matches selector width (4 bits)
        output_valid = 1'b0;
      end
      default: begin // Ensures full case coverage for output_valid
        output_valid = 1'b0;
      end
    endcase
  end

endmodule
