// This file defines a simple Verilog function outside of any module.
// According to the Verilog-2001 standard, functions must be defined within a module, generate block, or UDP.
// Placing it directly at the top level makes it an invalid design unit at that context.
// Therefore, SpyGlass will not find any valid top design unit and should report 'NoTopDUFound'.
function integer get_constant_value();
  get_constant_value = 42;
endfunction
