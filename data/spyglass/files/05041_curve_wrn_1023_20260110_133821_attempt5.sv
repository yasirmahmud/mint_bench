module curve_wrn_1023_20260110_133821_attempt5 (input clk, input rst);

  // The state register 'current_state' is explicitly sized [1:0]
  // and has the 'synopsys enum fsm' pragma. This setup is standard and
  // should not trigger any enum-related violations on the register itself.
  reg [1:0] /* synopsys enum fsm */ current_state;

  // These parameters are intended to be associated with the FSM states.
  // This line is designed to trigger WRN_1023 but avoid STX_VE_483.
  // WRN_1023: "enum directive requires parameter to have size specified"
  // This rule is triggered because the parameter declaration itself lacks an
  // explicit Verilog bit-width, i.e., it's missing '[1:0]' before STATE_IDLE.
  //
  // STX_VE_483: "The enum pragma must include a size (bit-width) specification"
  // This rule is averted by including '[1:0]' directly within the 'synopsys enum'
  // pragma itself, and by omitting the 'fsm' keyword for parameters.
  // The 'fsm' keyword within the pragma for parameters (as seen in context examples)
  // seems to contribute to STX_VE_483, so its removal is critical here.
  parameter /* synopsys enum [1:0] */ STATE_IDLE = 2'b00, STATE_A = 2'b01;

  // Minimal logic to use the signals and avoid unused warnings, and create a basic FSM.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      current_state <= STATE_IDLE;
    end else begin
      if (current_state == STATE_IDLE) begin
        current_state <= STATE_A;
      end else begin
        current_state <= STATE_IDLE;
      end
    end
  end

endmodule
