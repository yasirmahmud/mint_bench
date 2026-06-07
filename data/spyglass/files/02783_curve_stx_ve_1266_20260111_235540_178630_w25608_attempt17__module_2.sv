// STX_VE_1266: Implicit continuous assignment is not allowed within package.
// This line declares a 32-bit wire with an implicit continuous assignment
// directly inside a package, triggering the STX_VE_1266 rule.
// This is example #9, distinct from previous attempts by using a different
// variable name, width, and value.
package my_pkg_stx_ve_1266;
  wire [31:0] status_register_value = 32'h1234_5678;
endpackage
