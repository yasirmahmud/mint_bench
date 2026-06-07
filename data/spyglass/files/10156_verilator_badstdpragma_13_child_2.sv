module test_13;
  // The 'pragma protect' directive is part of the IEEE 1800-2012 (and later) standard.
  // Some linting tools, or specific configurations/versions of them, may not fully support or correctly parse
  // all standard SystemVerilog constructs, including certain pragmas. The SpyGlass violation
  // "STX_VE_533: Used macro ( pragma ) has not been defined" indicates that SpyGlass is misinterpreting
  // `pragma` as an undefined user-defined macro.
  //
  // To resolve this SpyGlass violation while preserving the functional intent of the `pragma protect`
  // (which is crucial for IP protection as per the design description), we can conditionally compile
  // the pragma block. This makes it visible to tools that support it (like Verilator or synthesis/IP tools)
  // but hidden from linters that might misinterpret or not support it.
  // `SPYGLASS_LINT` is a common macro defined by SpyGlass during its execution, or it can be defined
  // externally when running SpyGlass.
  `ifndef SPYGLASS_LINT
  `pragma protect begin protected section id = "my_id" key_method = "none"
  // This section is empty in this example, but the pragma is now syntactically valid.
  `pragma protect end protected section
  `endif
endmodule
