module curve_synth_12610_20260110_121924_attempt1 (
  input wire clk,
  input wire reset_n,
  input wire start_event,
  input wire end_event_input,
  output wire done_event
);

  // State declaration for FSM to avoid unused port warnings
  reg [1:0] state_reg;
  reg [1:0] next_state_logic;

  parameter STATE_IDLE       = 2'b00;
  parameter STATE_ACTIVE     = 2'b01;
  parameter STATE_WAIT_END   = 2'b10;

  always @(*) begin
    next_state_logic = state_reg; // Default to no change
    case (state_reg)
      STATE_IDLE: begin
        if (start_event) begin
          next_state_logic = STATE_ACTIVE;
        end
      end
      STATE_ACTIVE: begin
        // Wait for end_event_input in this state to transition
        if (end_event_input) begin
          next_state_logic = STATE_WAIT_END;
        end
      end
      STATE_WAIT_END: begin
        next_state_logic = STATE_IDLE; // Return to idle after one cycle
      end
      default: next_state_logic = STATE_IDLE; // Handle X/Z states
    endcase
  end

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      state_reg <= STATE_IDLE;
    end else begin
      state_reg <= next_state_logic;
    end
  end

  // Drive the output to avoid undriven output warning
  assign done_event = (state_reg == STATE_WAIT_END);


  // This sequence block is specifically crafted to trigger SYNTH_12610.
  // The rule 'large_delay_range_seq' targets SystemVerilog 'sequence' blocks 
  // with significant cycle delay ranges (e.g., ##[0:1500]), indicating they will 
  // be ignored for synthesis.
  // Although the module targets Verilog-2001, the 'sequence' and '##' syntax 
  // are SystemVerilog features that linting tools like SpyGlass will process.
  sequence s_long_wait;
    start_event ##[0:1500] end_event_input; // This line is the target of the SYNTH_12610 violation
  endsequence

endmodule
