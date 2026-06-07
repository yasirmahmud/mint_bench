module curve_stx_ve_648_20260111_225731_265941_w38092_attempt11;
  // STX_VE_648 violation: 'error_status' is declared as output though not in module header.
  // The module is declared without an explicit port list, causing this violation
  // when 'error_status' is declared as an output within the module body.
  output wire error_status;

  // Drive the declared output to avoid any 'unused signal' violations.
  assign error_status = 1'b0;

endmodule
