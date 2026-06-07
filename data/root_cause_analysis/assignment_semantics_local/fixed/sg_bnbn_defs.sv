`ifndef SG_BNBN_DEFS_SV
`define SG_BNBN_DEFS_SV

// FIX:
// Use NON-BLOCKING assignment for sequential flops.
`define SG_BNBN_ASSIGN(lhs, rhs) lhs <= rhs

`endif
