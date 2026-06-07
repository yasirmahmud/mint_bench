`ifndef SG_BNB_DEFS_SV
`define SG_BNB_DEFS_SV

// FIX:
// Use NON-BLOCKING assignment for sequential registers.
`define SG_BNB_ASSIGN(lhs, rhs) lhs <= rhs

`endif
