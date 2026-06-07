module curve_stx_ve_449_20260110_165220_attempt8 (
  input clk,
  input reset_n,
  output logic out_signal
);

  // STX_VE_449: Size of the enumeration constant ( 4 ) for enum label STATE_OVERFLOW is more than the range specified for the enumeration
  // This rule is specific to SystemVerilog 'typedef enum' with an explicit size constraint.
  // The module uses SystemVerilog constructs ('typedef enum', 'logic') to trigger the rule,
  // despite the request for Verilog-2001, as the rule itself pertains to SystemVerilog features.
  // Here, the 'system_state_t' enumeration is explicitly defined as 2-bit ('logic [1:0]').
  // 'STATE_OVERFLOW' implicitly gets the value 4, which cannot be represented in a 2-bit field (max value is 3),
  // thus triggering the violation at the definition of 'system_state_t'.
  typedef enum logic [1:0] { // 2-bit enum, allows values 0, 1, 2, 3
    STATE_BOOT,        // Value 0 (fits in 2-bit)
    STATE_CONFIGURE,   // Value 1 (fits in 2-bit)
    STATE_OPERATE,     // Value 2 (fits in 2-bit)
    STATE_HALT,        // Value 3 (fits in 2-bit)
    STATE_OVERFLOW     // Value 4 (implicitly assigned, requires 3 bits, violates 2-bit range)
  } system_state_t;

  system_state_t current_state_reg, next_state_reg;

  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_state_reg <= STATE_BOOT;
    end else begin
      current_state_reg <= next_state_reg;
    end
  end

  always_comb begin
    next_state_reg = current_state_reg; // Default assignment to avoid latches
    out_signal = 1'b0;                  // Default output value

    case (current_state_reg)
      STATE_BOOT: begin
        next_state_reg = STATE_CONFIGURE;
      end
      STATE_CONFIGURE: begin
        next_state_reg = STATE_OPERATE;
      end
      STATE_OPERATE: begin
        next_state_reg = STATE_HALT;
      end
      STATE_HALT: begin
        next_state_reg = STATE_BOOT; // Loop back to the first state
        out_signal = 1'b1;
      end
      // No explicit handling for STATE_OVERFLOW as it's an unreachable error state
    endcase
  end

endmodule
