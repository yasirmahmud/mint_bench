module curve_stx_ve_449_20260110_165220_attempt7 (
  input clk,
  input reset_n,
  output reg out_signal
);

  // STX_VE_449: Size of the enumeration constant ( 2 ) for enum label STATE_DONE is more than the range specified for the enumeration
  // This rule is specific to SystemVerilog 'typedef enum' with an explicit size constraint.
  // The module uses SystemVerilog constructs ('typedef enum', 'logic') to trigger the rule,
  // despite the request for Verilog-2001, as the rule itself pertains to SystemVerilog features.
  // Here, the 'fsm_state_t' enumeration is explicitly defined as 1-bit ('logic [0:0]').
  // 'STATE_DONE' implicitly gets the value 2, which cannot be represented in a 1-bit field,
  // thus triggering the violation at the definition of 'fsm_state_t'.
  typedef enum logic [0:0] {
    STATE_IDLE,    // Value 0 (fits in 1-bit)
    STATE_ACTIVE,  // Value 1 (fits in 1-bit)
    STATE_DONE     // Value 2 (implicitly assigned, requires 2 bits, violates 1-bit range)
  } fsm_state_t;

  fsm_state_t current_state, next_state;

  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_state <= STATE_IDLE;
    end else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    next_state = current_state; // Default assignment to avoid latches
    out_signal = 1'b0;          // Default output value

    case (current_state)
      STATE_IDLE: begin
        next_state = STATE_ACTIVE;
      end
      STATE_ACTIVE: begin
        next_state = STATE_DONE;
      end
      STATE_DONE: begin
        out_signal = 1'b1;
        next_state = STATE_IDLE;
      end
    endcase
  end

endmodule
