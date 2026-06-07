module rritag_LocalBist ( BIST_ADR, BIST_WE, func_do, 
    ERRN_ON, INVERSE, NO_COMP, 
    END_SEQ, BACKGROUND, rritag_ERROR, PATTERN );

input  [`it_msb+1:0] func_do;
input  [`ic_msb-4:0] BIST_ADR;
input  BIST_WE, ERRN_ON, 
    INVERSE, NO_COMP, END_SEQ, BACKGROUND;
output rritag_ERROR;
output [`it_msb+1:0] PATTERN;

endmodule
