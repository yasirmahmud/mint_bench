module PE_1_DW01_add_0 ( A , B , CI , SUM , CO ) ;
input  [8:0] A ;
input  [8:0] B ;
input  CI ;
output [8:0] SUM ;
output CO ;

wire [8:1] carry ;

// Add module definitions for black-box instances to resolve ErrorAnalyzeBBox violations.
// FADDX1_LVT: Full Adder
