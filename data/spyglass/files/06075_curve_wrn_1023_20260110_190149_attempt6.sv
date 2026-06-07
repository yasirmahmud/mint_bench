module curve_wrn_1023_20260110_190149_attempt6 ();

  // WRN_1023: enum directive requires parameter to have size specified
  // The /* synopsys enum fsm */ directive is missing the [size] specification.
  parameter /* synopsys enum fsm */
    STATE_IDLE = 2'd0,
    STATE_RUN  = 2'd1,
    STATE_STOP = 2'd2;

  // Declare a register to use the parameters, avoiding unused warnings
  reg [1:0] current_state;

  // Use the parameters and the register to satisfy usage requirements
  initial begin
    current_state = STATE_IDLE;
  end

endmodule
