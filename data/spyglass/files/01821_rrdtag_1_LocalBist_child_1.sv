module rrdtag_1_LocalBist #(
    parameter DT_WIDTH = 32
) (
    input  [DT_WIDTH-1:0] func_do,
    output [DT_WIDTH-1:0] BIST_PATTERN,
    input  [8:0] BIST_ADR,
    input  BIST_WE,
    input  BIST_ON,
    input  ERRN_ON,
    input  INVERSE,
    input  NO_COMP,
    input  END_SEQ,
    input  rrdtag_1_ENABLE,
    input  BACKGROUND,
    output rrdtag_1_ERROR,
    output we
);

endmodule
