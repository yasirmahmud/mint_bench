module curve_w263_20260111_200524_686981_w47100_attempt8 (
  input wire [4:0] state_selector_in,
  output reg       status_out
);

  reg [4:0] current_state; // Selector width: 5 bits

  // Local parameters for states
  localparam [4:0] IDLE_STATE   = 5'd0; // Matches selector width
  localparam [4:0] ACTIVE_STATE = 5'd1; // Matches selector width
  localparam [2:0] ERROR_STATE  = 3'd2; // VIOLATION: Mismatched width (3 bits vs 5 bits)
  localparam [4:0] DONE_STATE   = 5'd3; // Matches selector width

  always @(*) begin
    current_state = state_selector_in; // Assign input to selector
    status_out = 1'b0; // Default output

    case (current_state) // Selector is 5 bits wide
      IDLE_STATE: begin
        status_out = 1'b0;
      end
      ACTIVE_STATE: begin
        status_out = 1'b1;
      end
      // This case label (ERROR_STATE) has an explicit width of 3 bits,
      // which does not match the selector (current_state) width of 5 bits.
      // This triggers the W263 violation.
      ERROR_STATE: begin
        status_out = 1'b0;
      end
      DONE_STATE: begin
        status_out = 1'b1;
      end
      default: begin
        status_out = 1'b0;
      end
    endcase
  end

endmodule
