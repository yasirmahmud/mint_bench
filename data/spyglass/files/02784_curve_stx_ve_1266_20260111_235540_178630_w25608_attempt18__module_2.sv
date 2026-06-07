// STX_VE_1266: Implicit continuous assignment is not allowed within package.
// This line declares a 64-bit wire with an implicit continuous assignment
// directly inside a package, triggering the STX_VE_1266 rule.
// This is example #10, distinct from previous attempts by using a different
// variable name, width, and value.
package my_pkg_stx_ve_1266_ex10;
  wire [63:0] config_word_data = 64'hFEDC_BA98_7654_3210;
endpackage
