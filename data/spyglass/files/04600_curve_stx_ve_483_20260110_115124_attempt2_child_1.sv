module curve_stx_ve_483_20260110_115124_attempt2 (
  output dummy_out
);

  // STX_VE_483: The enum pragma must include a size (bit-width) specification.
  // This pragma intentionally lacks the '[size]' specifier, e.g., /* synopsys enum fsm [2] */
  // to trigger STX_VE_483.
  // The parameters themselves include an explicit bit-width declaration '[1:0]',
  // which is intended to prevent WRN_1023 by ensuring the parameter has a specified size in its declaration.
  parameter /* synopsys enum fsm [2] */ [1:0]
    STATE_IDLE   = 2'b00,
    STATE_ACTIVE = 2'b01,
    STATE_FINISH = 2'b10;

  assign dummy_out = STATE_IDLE[0];

endmodule
