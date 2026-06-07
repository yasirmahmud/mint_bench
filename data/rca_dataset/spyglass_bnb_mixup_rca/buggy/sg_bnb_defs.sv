`ifndef SG_BNB_DEFS_SV
`define SG_BNB_DEFS_SV

// ROOT BUG:
// This macro is intended for sequential flops, but mistakenly uses a BLOCKING assignment ('=')
// instead of a NON-BLOCKING assignment ('<=').
//
// Because the reset path uses '<=' and the data path uses this macro, each register ends up with
// a blocking/non-blocking mix-up that produces many dependent SpyGlass violations.
`define SG_BNB_ASSIGN(lhs, rhs) lhs = rhs

`endif
