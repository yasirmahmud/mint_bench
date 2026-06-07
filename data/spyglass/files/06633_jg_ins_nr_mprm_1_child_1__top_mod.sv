module top_mod;
  // This instance no longer provides an extra parameter 'P_EXTRA' that does not exist in 'sub_mod'.
  // Removing the unrecognized parameter resolves the STX_VE_481 syntax error and the INS_NR_MPRM warning.
  sub_mod #(.P1(20)) inst_too_many_params();
endmodule
