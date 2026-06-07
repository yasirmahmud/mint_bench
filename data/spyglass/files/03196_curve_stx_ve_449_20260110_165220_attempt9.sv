module curve_stx_ve_449_20260110_165220_attempt9 (
  input logic clk,
  input logic reset_n,
  output logic out_signal
);

  // STX_VE_449: Size of the enumeration constant for enum label STATE_PAUSED is more than the range specified for the enumeration
  // This rule is specific to SystemVerilog 'typedef enum' with an explicit size constraint.
  // The module uses SystemVerilog constructs ('typedef enum', 'logic') to trigger the rule,
  // despite the request for Verilog-2001, as the rule itself pertains to SystemVerilog features.
  // Here, the 'processing_state_t' enumeration is explicitly defined as 1-bit ('logic [0:0]').
  // 'STATE_PAUSED' implicitly gets the value 2, which cannot be represented in a 1-bit field (max value is 1),
  // thus triggering the violation at the definition of 'processing_state_t'.
  typedef enum logic [0:0] { // 1-bit enum, allows values 0, 1
    STATE_IDLE,      // Value 0 (fits in 1-bit)
    STATE_RUNNING,   // Value 1 (fits in 1-bit)
    STATE_PAUSED     // Value 2 (implicitly assigned, requires 2 bits, violates 1-bit range)
  } processing_state_t;

  processing_state_t current_state_reg, next_state_reg;

  // Simple sequential logic using the enum states
  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_state_reg <= STATE_IDLE;
    end else begin
      current_state_reg <= next_state_reg;
    end
  end

  // Simple combinational logic for next state and output
  always_comb begin
    next_state_reg = current_state_reg; // Default assignment to avoid latches
    out_signal = 1'b0;                  // Default output value

    case (current_state_reg)
      STATE_IDLE: begin
        next_state_reg = STATE_RUNNING;
      end
      STATE_RUNNING: begin
        next_state_reg = STATE_IDLE; // Loop back to IDLE
        out_signal = 1'b1;
      end
      // No explicit case for STATE_PAUSED as it represents an out-of-range value.
      // A 'default' ensures full case coverage and prevents latches.
      default: begin
        next_state_reg = STATE_IDLE; // Transition to a valid state if an illegal state is somehow reached
      end
    endcase
  end

endmodule
