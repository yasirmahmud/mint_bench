module top_module;
  // This is a minimal Verilog-2001 module wrapper.
  // The actual STX_VE_1266 violation occurs within the SystemVerilog package below.
  // SpyGlass, when configured, can parse SystemVerilog constructs even if the
  // primary design target might be Verilog-2001, allowing this rule to be triggered.
endmodule
