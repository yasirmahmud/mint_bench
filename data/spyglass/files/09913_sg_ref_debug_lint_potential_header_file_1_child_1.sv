'define MY_MACRO_EX1 10

module sg_ref_debug_lint_potential_header_file_1_child_1_module;
  // This module is added to resolve the DEBUG_LINT_POTENTIAL_HEADER_FILE
  // rule by ensuring the file contains a module declaration,
  // and to address the STX_VE_481 syntax error which can occur
  // when a Verilog file solely consists of preprocessor directives.
  // The functional behavior of the macro definition is preserved.
endmodule
