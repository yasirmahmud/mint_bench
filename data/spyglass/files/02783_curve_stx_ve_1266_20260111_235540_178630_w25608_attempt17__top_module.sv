module top_module;
  // This is a minimal Verilog-2001 module.
  // It serves as a wrapper. The actual violation for STX_VE_1266
  // occurs within the package construct below, as per the rule definition.
  // Verilog-2001 does not officially support 'package' constructs,
  // but tools like SpyGlass will parse SystemVerilog features if enabled,
  // allowing this specific rule to be triggered.
endmodule
