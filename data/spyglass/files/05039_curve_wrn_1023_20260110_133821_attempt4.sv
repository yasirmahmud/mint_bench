module curve_wrn_1023_20260110_133821_attempt4 (input clk);

  // The state register 'current_state' is explicitly sized [1:0]
  // and has the 'synopsys enum fsm' pragma. This setup avoids STX_VE_483.
  reg [1:0] /* synopsys enum fsm */ current_state;

  // These parameters are intended to be associated with the FSM states.
  // They include the 'synopsys enum fsm' pragma but lack an explicit bit-width
  // declaration before the parameter name (e.g., '[1:0] STATE_IDLE').
  // This missing explicit size declaration, despite the literal values having a width,
  // is expected to trigger exactly one WRN_1023 violation as per the rule description.
  parameter /* synopsys enum fsm */ STATE_IDLE = 2'b00, STATE_A = 2'b01;

  // Minimal logic to use the signals and avoid unused warnings.
  always @(posedge clk) begin
    if (current_state == STATE_IDLE) begin
      current_state <= STATE_A;
    end else begin
      current_state <= STATE_IDLE;
    end
  end

endmodule
