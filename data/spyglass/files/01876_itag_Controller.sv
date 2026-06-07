module itag_Controller ( TCLK, TRESET, MODE, rritag_ERROR, BIST_ADR, BIST_WE, 
    INVERSE, END_SEQ, BIST_ON, ERRN_ON, NO_COMP, BACKGROUND, DONE, 
    ERROR, FAIL, test_mode );
input  [1:0] MODE;
output [`ic_msb-4:0] BIST_ADR;
input  TCLK, TRESET, rritag_ERROR, test_mode;
output BIST_WE, INVERSE, END_SEQ, BIST_ON, ERRN_ON, NO_COMP, BACKGROUND, 
    DONE, ERROR, FAIL;

endmodule
