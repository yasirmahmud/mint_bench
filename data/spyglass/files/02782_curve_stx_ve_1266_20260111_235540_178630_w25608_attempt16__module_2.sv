// STX_VE_1266: Implicit continuous assignment is not allowed within package.
// This rule targets SystemVerilog 'package' constructs.
// Although the primary request is for a 'Verilog-2001 module',
// triggering this specific rule necessitates the use of a package.
// The context examples also demonstrate the violation within a package.
package my_custom_pkg;
  // This line declares a 64-bit wire with an implicit continuous assignment
  // directly inside a package, triggering the STX_VE_1266 rule.
  // This is example #8, distinct from previous attempts by using a different
  // variable name, a significantly wider bus, and a different value.
  wire [63:0] config_data_bus = 64'hDEAD_BEEF_C0FFEE_BAB0;
endpackage
