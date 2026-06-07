module curve_stx_ve_483_20260110_115124_attempt3 (
  output wire dummy_out
);

  // STX_VE_483: The enum pragma must include a size (bit-width) specification.
  // This pragma intentionally lacks the '[size]' specifier to trigger STX_VE_483.
  // Example: /* synopsys enum fsm [2] */
  parameter [1:0] STATE_IDLE /* synopsys enum fsm */ = 2'b00;

  assign dummy_out = STATE_IDLE[0];

endmodule
