// STX_VE_1266: Implicit continuous assignment is not allowed within package.
// This line declares a 32-bit wire with an implicit continuous assignment
// directly inside a package, triggering the STX_VE_1266 rule.
// This is example #11, distinct from previous attempts by using a different
// package name, variable name, width, and value.
package my_stx_pkg_11;
  wire [31:0] enable_mask_reg = 32'hAAAA_BBBB;
endpackage
