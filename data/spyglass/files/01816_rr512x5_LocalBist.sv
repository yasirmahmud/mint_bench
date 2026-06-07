module rr512x5_LocalBist ( BIST_ADR, BIST_WE,
    func_doa, BIST_ON, ERRN_ON, INVERSE,
    NO_COMP, END_SEQ, rr512x5_ENABLE, BACKGROUND,  BIST_PATTERN, web,
    rr512x5_ERROR );
    
input  [4:0] func_doa;
output [4:0] BIST_PATTERN;
input  [8:0] BIST_ADR;
input  BIST_WE, BIST_ON, ERRN_ON, INVERSE,
       NO_COMP, END_SEQ, rr512x5_ENABLE, BACKGROUND;
output rr512x5_ERROR, web;

endmodule
