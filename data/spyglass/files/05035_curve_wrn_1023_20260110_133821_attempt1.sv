module curve_wrn_1023_20260110_133821_attempt1 ();
  // WRN_1023: enum directive requires parameter to have size specified
  // The parameter 'MY_STATE_IDLE' is associated with an 'enum fsm' directive,
  // but its size is not explicitly declared in the parameter declaration itself (e.g., [1:0]).
  parameter /* synopsys enum fsm */ MY_STATE_IDLE = 2'b00;
endmodule
