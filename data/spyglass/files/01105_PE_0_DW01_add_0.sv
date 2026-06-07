module PE_0_DW01_add_0 ( A , B , CI , SUM , CO ) ;
input  [8:0] A ;
input  [8:0] B ;
input  CI ;
output [8:0] SUM ;
output CO ;

wire [8:1] carry ;

FADDX1_LVT U1_3 ( .A ( A[3] ) , .B ( B[3] ) , .CI ( carry[3] ) , 
    .CO ( carry[4] ) , .S ( SUM[3] ) ) ;
FADDX1_LVT U1_2 ( .A ( A[2] ) , .B ( B[2] ) , .CI ( carry[2] ) , 
    .CO ( carry[3] ) , .S ( SUM[2] ) ) ;
FADDX1_LVT U1_1 ( .A ( A[1] ) , .B ( B[1] ) , .CI ( carry[1] ) , 
    .CO ( carry[2] ) , .S ( SUM[1] ) ) ;
FADDX1_LVT U1_7 ( .A ( A[7] ) , .B ( B[7] ) , .CI ( carry[7] ) , 
    .CO ( SUM[8] ) , .S ( SUM[7] ) ) ;
FADDX1_LVT U1_6 ( .A ( A[6] ) , .B ( B[6] ) , .CI ( carry[6] ) , 
    .CO ( carry[7] ) , .S ( SUM[6] ) ) ;
FADDX1_LVT U1_5 ( .A ( A[5] ) , .B ( B[5] ) , .CI ( carry[5] ) , 
    .CO ( carry[6] ) , .S ( SUM[5] ) ) ;
FADDX1_LVT U1_4 ( .A ( A[4] ) , .B ( B[4] ) , .CI ( carry[4] ) , 
    .CO ( carry[5] ) , .S ( SUM[4] ) ) ;
XOR2X1_LVT U1 ( .A1 ( A[0] ) , .A2 ( B[0] ) , .Y ( SUM[0] ) ) ;
AND2X1_LVT U2 ( .A1 ( A[0] ) , .A2 ( B[0] ) , .Y ( carry[1] ) ) ;
endmodule
