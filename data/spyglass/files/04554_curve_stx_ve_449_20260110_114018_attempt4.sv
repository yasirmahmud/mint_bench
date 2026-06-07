module curve_stx_ve_449_20260110_114018_attempt4 (
  input wire clk,
  input wire rst_n,
  input wire input_go,
  output reg output_done
);

  // STX_VE_449: Size of the enumeration constant ( 2 ) for enum label STATE_DONE is more than the range specified for the enumeration
  // Explanation:
  // SpyGlass often infers enumerations for FSM states defined using localparams in Verilog-2001.
  // For an FSM with two distinct states (STATE_IDLE, STATE_DONE), SpyGlass is expected to infer that the minimal
  // required range for the state register is 1 bit (e.g., values 0 or 1).
  // However, STATE_DONE is explicitly assigned the value 2 (binary '10'), which inherently requires 2 bits to represent.
  // This value (2) for STATE_DONE exceeds the inferred 1-bit range of the enumeration when assigned to 'next_state'/
  // 'current_state' which are implicitly 1-bit wide 'reg' declarations in Verilog-2001.
  // This combination of a multi-bit enumeration constant value (2) and an inferred single-bit enumeration range triggers STX_VE_449.

  localparam STATE_IDLE = 0; // Value 0, fits within 1 bit
  localparam STATE_DONE = 2; // Value 2 (binary '10'), requires 2 bits to represent

  // FSM state registers, implicitly 1-bit wide in Verilog-2001 for a simple 'reg' declaration
  reg current_state;
  reg next_state;

  // Sequential logic for state update
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      current_state <= STATE_IDLE;
    end else begin
      current_state <= next_state; // The assignment where next_state (potentially STATE_DONE=2) is truncated to 1 bit
    end
  end

  // Combinational logic for next state and output
  always @(*) begin
    // Default assignments to prevent latches
    next_state = current_state;
    output_done = 1'b0; // Default output assignment

    case (current_state)
      STATE_IDLE: begin
        if (input_go) begin
          next_state = STATE_DONE; // Triggers STX_VE_449: STATE_DONE (2) is assigned to 1-bit 'next_state'
        end
      end
      STATE_DONE: begin
        output_done = 1'b1;
        // Stay in DONE state, or transition out based on conditions not shown for minimality.
      end
      default: begin
        // Defensive assignment for full case coverage to prevent latches if current_state somehow gets an unexpected value
        next_state = STATE_IDLE;
      end
    endcase
  end

endmodule
