module top_mod;
  // This instance provides an extra parameter 'P_EXTRA' that does not exist in 'sub_mod'.
  sub_mod #(.P1(20), .P_EXTRA(30)) inst_too_many_params();
endmodule
