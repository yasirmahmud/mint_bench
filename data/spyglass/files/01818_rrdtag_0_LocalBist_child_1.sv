module rrdtag_0_LocalBist #(
    parameter dt_msb = 31 // Default data width, can be overridden
) (
    input  [8:0] BIST_ADR,
    input  BIST_WE,
    input  [`dt_msb:0] func_do,
    input  BIST_ON,
    input  ERRN_ON,
    input  INVERSE,
    input  NO_COMP,
    input  END_SEQ,
    input  rrdtag_0_ENABLE,
    input  BACKGROUND,
    output [`dt_msb:0] BIST_PATTERN,
    output we,
    output rrdtag_0_ERROR
);

endmodule
