`define it_msb 31
`define ic_msb 19

module rritag_LocalBist (
    input  [`ic_msb-4:0] BIST_ADR,
    input  BIST_WE,
    input  [`it_msb+1:0] func_do,
    input  ERRN_ON,
    input  INVERSE,
    input  NO_COMP,
    input  END_SEQ,
    input  BACKGROUND,
    output rritag_ERROR,
    output [`it_msb+1:0] PATTERN
);

endmodule
