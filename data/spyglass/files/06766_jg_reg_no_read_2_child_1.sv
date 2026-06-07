module unread_reg_example2 (
  input wire enable,
  input wire value_in
);

  // The register 'another_unused_reg' and its associated logic have been removed.
  // This resolves the REG_NO_READ violation (W528) because the register was
  // being assigned but never read. Since the module has no outputs and the
  // register did not affect any other observable behavior, its removal
  // preserves the functional behavior of the design while resolving the linting issue.

endmodule
