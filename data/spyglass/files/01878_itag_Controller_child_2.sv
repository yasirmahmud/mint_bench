module itag_Controller #(
    parameter ic_msb = 11
) (
    input TCLK,
    input TRESET,
    input [1:0] MODE,
    input rritag_ERROR,
    output [ic_msb-4:0] BIST_ADR,
    output BIST_WE,
    output INVERSE,
    output END_SEQ,
    output BIST_ON,
    output ERRN_ON,
    output NO_COMP,
    output BACKGROUND,
    output DONE,
    output ERROR,
    output FAIL,
    input test_mode
);

endmodule
