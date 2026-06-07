module rrdtag_1_LocalBist ( BIST_ADR, BIST_WE, 
    func_do, BIST_ON, ERRN_ON, INVERSE, 
    NO_COMP, END_SEQ, rrdtag_1_ENABLE, BACKGROUND, BIST_PATTERN, we, 
    rrdtag_1_ERROR );

input  [`dt_msb:0] func_do;
output [`dt_msb:0] BIST_PATTERN;
input  [8:0] BIST_ADR;
input  BIST_WE, BIST_ON, ERRN_ON, INVERSE,
       NO_COMP, END_SEQ, rrdtag_1_ENABLE, BACKGROUND;
output rrdtag_1_ERROR, we;

endmodule
