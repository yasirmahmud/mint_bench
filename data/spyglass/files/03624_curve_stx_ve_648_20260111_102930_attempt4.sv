module curve_stx_ve_648_20260111_102930_attempt4;

  // STX_VE_648: This 'output' declaration triggers the violation
  // because the module header does not have an explicit port list.
  output wire data_out;

  // Assign a value to avoid unused signal warnings.
  assign data_out = 1'b1;

endmodule
