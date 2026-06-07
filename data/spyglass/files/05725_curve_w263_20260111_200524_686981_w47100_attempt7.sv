module curve_w263_20260111_200524_686981_w47100_attempt7 (
  input wire [3:0] state_input_bus,
  output reg [1:0] output_status
);

  reg [3:0] current_state_reg; // Selector width: 4 bits

  // Parameters for states
  parameter [3:0] STATE_IDLE = 4'd0;    // Matches selector width (4 bits)
  parameter [3:0] STATE_RUN = 4'd1;     // Matches selector width (4 bits)
  parameter         STATE_VIOLATION = 2'b10; // Mismatched width (2 bits)
  parameter [3:0] STATE_DONE = 4'd3;    // Matches selector width (4 bits)

  always @(*) begin
    current_state_reg = state_input_bus;
    output_status = 2'b00; // Default output

    case (current_state_reg) // Selector width is 4 bits
      STATE_IDLE: begin
        output_status = 2'b01;
      end
      STATE_RUN: begin
        output_status = 2'b10;
      end
      // This case label (STATE_VIOLATION) has an explicit width of 2 bits,
      // which does not match the selector (current_state_reg) width of 4 bits.
      // This triggers the W263 violation.
      STATE_VIOLATION: begin
        output_status = 2'b11;
      end
      STATE_DONE: begin
        output_status = 2'b00;
      end
      default: begin
        output_status = 2'b00;
      end
    endcase
  end

endmodule
