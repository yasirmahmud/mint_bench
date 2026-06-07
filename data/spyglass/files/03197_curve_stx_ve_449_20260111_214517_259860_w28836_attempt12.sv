module curve_stx_ve_449_20260111_214517_259860_w28836_attempt12 (
  input wire        clk,
  input wire        reset_n,
  input wire        start_operation,
  output reg        operation_done
);

  // STX_VE_449 violation: The enumeration range is 1-bit ([0:0]),
  // but the implicitly assigned value for STATE_DONE is 2, which requires 2 bits.
  typedef enum logic [0:0] {
    STATE_IDLE,        // Value 0 (fits in 1-bit)
    STATE_ACTIVE,      // Value 1 (fits in 1-bit)
    STATE_DONE         // Value 2 (implicitly assigned, requires 2 bits)
  } fsm_state_t;

  fsm_state_t current_state_reg, next_state_reg;

  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_state_reg <= STATE_IDLE;
    end else begin
      current_state_reg <= next_state_reg;
    end
  end

  always_comb begin
    next_state_reg = current_state_reg;
    operation_done = 1'b0;

    case (current_state_reg)
      STATE_IDLE: begin
        if (start_operation) begin
          next_state_reg = STATE_ACTIVE;
        end
      end
      STATE_ACTIVE: begin
        next_state_reg = STATE_DONE;
      end
      STATE_DONE: begin
        operation_done = 1'b1;
        if (!start_operation) begin
          next_state_reg = STATE_IDLE;
        end
      end
      default: begin
        next_state_reg = STATE_IDLE;
      end
    endcase
  end

endmodule
