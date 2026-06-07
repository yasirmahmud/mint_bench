`ifndef SG_BNBN_DEFS_SV
`define SG_BNBN_DEFS_SV

// ROOT BUG:
// This macro is intended for sequential flops, but mistakenly uses a BLOCKING assignment ('=')
// instead of a NON-BLOCKING assignment ('<=').
//
// Each always_ff block in this dataset uses '<=' on reset and this macro on the data path.
// The single operator mistake therefore produces many dependent SpyGlass violations across
// multiple modules.
`define SG_BNBN_ASSIGN(lhs, rhs) lhs = rhs

`endif
