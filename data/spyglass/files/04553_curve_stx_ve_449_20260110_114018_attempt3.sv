module curve_stx_ve_449_20260110_114018_attempt3 (
  input wire clk,
  input wire rst_n,
  output wire state_output
);

  // STX_VE_449: Size of the enumeration constant ( 2 ) for enum label STATE_DONE is more than the range specified for the enumeration
  // Explanation:
  // SpyGlass often infers enumerations for FSM states defined using localparams.
  // For an FSM with two distinct states (STATE_IDLE, STATE_DONE), SpyGlass is expected to infer that the *minimal* required range for this enumeration is 1 bit (e.g., values 0 or 1).
  // However, STATE_DONE is explicitly assigned the value 2 (binary '10'), which inherently requires 2 bits to represent.
  // This value (2) for STATE_DONE exceeds the inferred 1-bit range of the enumeration.
  // The FSM state register 'current_state' is declared as 1-bit wide (implicitly [0:0]) to guide SpyGlass towards inferring a 1-bit enumeration range.
  // This combination of a multi-bit enumeration constant value (2) and an inferred single-bit enumeration range triggers STX_VE_449.
  localparam STATE_IDLE = 0; // Value 0, fits within 1 bit
  localparam STATE_DONE = 2; // Value 2, requires 2 bits to represent

  // FSM state registers, declared as 1-bit wide to suggest a 1-bit enumeration range
  reg current_state; // 1-bit wide (implicitly [0:0] in Verilog-2001)
  reg next_state;    // 1-bit wide

  // Sequential logic for state update
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      current_state <= STATE_IDLE; // Assigns 0 to 1-bit reg (fits)
    end else begin
      current_state <= next_state;
    end
  end

  // Combinational logic for next state and output
  always @(*) begin
    // Default assignments to prevent latches and multiple drivers
    next_state = current_state;
    state_output = current_state; // Use current_state for the output to avoid unused signal warnings

    case (current_state) // The case analyzes the 1-bit 'current_state'
      STATE_IDLE: begin // current_state is 0
        next_state = STATE_DONE; // Attempt to assign value 2 (STATE_DONE) to a 1-bit 'next_state'. This assignment contributes to the inferred enumeration behavior but may also implicitly trigger width mismatch warnings if SpyGlass does not prioritize STX_VE_449.
      end
      // Note: If 'current_state' is 1-bit, 'STATE_DONE' (value 2) can never be matched directly by 'current_state' because 2 truncates to 0.
      // However, its presence in the 'localparam' list is essential for the tool to consider it part of the 'enumeration'.
      default: begin // Covers cases where current_state might be 1'b1 or X/Z, or effectively STATE_DONE when truncated
        next_state = STATE_IDLE;
      end
    endcase
  end

endmodule
