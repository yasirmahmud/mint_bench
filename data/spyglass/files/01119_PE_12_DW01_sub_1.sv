module PE_12_DW01_sub_1 ( A , B , CI , DIFF , CO ) ;
input  [7:0] A ;
input  [7:0] B ;
input  CI ;
output [7:0] DIFF ;
output CO ;

wire [8:0] carry ;

FADDX1_LVT U2_7 ( .A ( A[7] ) , .B ( n3 ) , .CI ( carry[7] ) , 
    .S ( DIFF[7] ) ) ;
FADDX1_LVT U2_6 ( .A ( A[6] ) , .B ( n4 ) , .CI ( carry[6] ) , 
    .CO ( carry[7] ) , .S ( DIFF[6] ) ) ;
FADDX1_LVT U2_5 ( .A ( A[5] ) , .B ( n5 ) , .CI ( carry[5] ) , 
    .CO ( carry[6] ) , .S ( DIFF[5] ) ) ;
FADDX1_LVT U2_4 ( .A ( A[4] ) , .B ( n6 ) , .CI ( carry[4] ) , 
    .CO ( carry[5] ) , .S ( DIFF[4] ) ) ;
FADDX1_LVT U2_3 ( .A ( A[3] ) , .B ( n7 ) , .CI ( carry[3] ) , 
    .CO ( carry[4] ) , .S ( DIFF[3] ) ) ;
FADDX1_LVT U2_2 ( .A ( A[2] ) , .B ( n8 ) , .CI ( carry[2] ) , 
    .CO ( carry[3] ) , .S ( DIFF[2] ) ) ;
FADDX1_LVT U2_1 ( .A ( A[1] ) , .B ( n1 ) , .CI ( carry[1] ) , 
    .CO ( carry[2] ) , .S ( DIFF[1] ) ) ;
INVX1_LVT U1 ( .A ( B[0] ) , .Y ( n2 ) ) ;
INVX1_LVT U2 ( .A ( B[1] ) , .Y ( n1 ) ) ;
OR2X1_LVT U3 ( .A1 ( n2 ) , .A2 ( A[0] ) , .Y ( carry[1] ) ) ;
INVX1_LVT U4 ( .A ( B[2] ) , .Y ( n8 ) ) ;
INVX1_LVT U5 ( .A ( B[3] ) , .Y ( n7 ) ) ;
INVX1_LVT U6 ( .A ( B[4] ) , .Y ( n6 ) ) ;
INVX1_LVT U7 ( .A ( B[5] ) , .Y ( n5 ) ) ;
INVX1_LVT U8 ( .A ( B[6] ) , .Y ( n4 ) ) ;
INVX1_LVT U9 ( .A ( B[7] ) , .Y ( n3 ) ) ;
XNOR2X1_LVT U10 ( .A1 ( A[0] ) , .A2 ( n2 ) , .Y ( DIFF[0] ) ) ;
endmodule
