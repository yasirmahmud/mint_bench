module curve_wrn_1023_20260110_190149_attempt7 ();

  // WRN_1023: enum directive requires parameter to have size specified
  // This example attempts to trigger WRN_1023 by having the 'enum fsm' pragma
  // present for parameters, but the parameters themselves do not have an
  // explicit bit-width range (e.g., parameter [1:0] STATE_IDLE = ...).
  // It specifies a valid bit-width range within the pragma itself ([1:0])
  // to prevent the STX_VE_483 fatal error, which seems to target the pragma's
  // internal size specification.
  parameter /* synopsys enum fsm [1:0] */
    STATE_IDLE = 2'd0,
    STATE_RUN  = 2'd1,
    STATE_STOP = 2'd2;

  // Declare a register and assign to it to avoid unused parameter warnings
  reg [1:0] current_state;

  initial begin
    current_state = STATE_IDLE;
  end

endmodule
