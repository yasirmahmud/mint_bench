module curve_stx_ve_483_20260110_115124_attempt4 (
  output wire dummy_out
);

  // STX_VE_483: The enum pragma must include a size (bit-width) specification.
  // This pragma intentionally lacks the '[size]' specifier to trigger STX_VE_483.
  // Example of correct pragma: /* synopsys enum fsm [2] */
  parameter /* synopsys enum fsm [2] */ STATE_IDLE = 2'b00;

  // Use the parameter to avoid an unused signal warning
  assign dummy_out = STATE_IDLE[0];

endmodule
