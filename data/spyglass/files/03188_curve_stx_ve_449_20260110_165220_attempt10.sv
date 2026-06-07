module curve_stx_ve_449_20260110_165220_attempt10 (
  input logic clk,
  input logic reset_n,
  input logic enable_transition, // Input to control state transitions
  output logic status_active_indicator // Output to indicate a specific status
);

  // STX_VE_449: Size of the enumeration constant for enum label STATUS_OVERFLOW is more than the range specified for the enumeration
  // This rule is specific to SystemVerilog 'typedef enum' with an explicit size constraint.
  // The module uses SystemVerilog constructs ('typedef enum', 'logic') to trigger the rule,
  // despite the request for Verilog-2001, as the rule itself pertains to SystemVerilog features.
  // Here, the 'system_status_t' enumeration is explicitly defined as 2-bit ('logic [1:0]').
  // 'STATUS_OVERFLOW' implicitly gets the value 4, which cannot be represented in a 2-bit field (max value is 3),
  // thus triggering the violation at the definition of 'system_status_t'.
  typedef enum logic [1:0] { // 2-bit enum, allows values 0, 1, 2, 3
    STATUS_IDLE,       // Value 0 (fits in 2-bit)
    STATUS_ACTIVE,     // Value 1 (fits in 2-bit)
    STATUS_COMPLETE,   // Value 2 (fits in 2-bit)
    STATUS_ERROR,      // Value 3 (fits in 2-bit)
    STATUS_OVERFLOW    // Value 4 (implicitly assigned, requires 3 bits, violates 2-bit range)
  } system_status_t;

  system_status_t current_status_reg, next_status_reg;

  // Minimal sequential logic for state register
  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_status_reg <= STATUS_IDLE;
    end else begin
      current_status_reg <= next_status_reg;
    end
  end

  // Minimal combinational logic for next state and output
  always_comb begin
    next_status_reg = current_status_reg; // Default assignment to avoid latches
    status_active_indicator = 1'b0;      // Default output value

    case (current_status_reg)
      STATUS_IDLE: begin
        if (enable_transition) begin
          next_status_reg = STATUS_ACTIVE;
        end
      end
      STATUS_ACTIVE: begin
        status_active_indicator = 1'b1;
        if (!enable_transition) begin
          next_status_reg = STATUS_COMPLETE;
        end
      end
      STATUS_COMPLETE: begin
        // Stay in complete or transition back to idle
        next_status_reg = STATUS_IDLE;
      end
      // STATUS_ERROR and STATUS_OVERFLOW are not explicitly handled in the FSM logic
      // as the violation occurs at declaration, not usage, and default ensures no latch.
      default: begin
        next_status_reg = STATUS_IDLE; // Handles unhandled states or potential error states
      end
    endcase
  end

endmodule
