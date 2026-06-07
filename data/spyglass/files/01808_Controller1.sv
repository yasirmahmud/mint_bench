module Controller1 ( TCLK, TRESET, MODE, rrdtag_0_ERROR, 
    rrdtag_1_ERROR, rr512x5_ERROR, BIST_ADR, rrdtag_0_ENABLE, rrdtag_1_ENABLE, 
    rr512x5_ENABLE, BIST_WE, INVERSE, END_SEQ, BIST_ON, ERRN_ON, NO_COMP, 
    BACKGROUND, DONE, ERROR, FAIL, test_mode );
input  [1:0] MODE;
output [8:0] BIST_ADR;
input  TCLK, TRESET, rrdtag_0_ERROR, rrdtag_1_ERROR, rr512x5_ERROR, test_mode;
output rrdtag_0_ENABLE, rrdtag_1_ENABLE, rr512x5_ENABLE, BIST_WE, INVERSE, 
    END_SEQ, BIST_ON, ERRN_ON, NO_COMP, BACKGROUND, DONE, ERROR, FAIL;
    
endmodule
