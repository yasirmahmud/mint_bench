module PE_14 ( clock , R , S1 , S2 , S1S2mux , newDist , Accumulate , Rpipe ) ;
input  clock ;
input  [7:0] R ;
input  [7:0] S1 ;
input  [7:0] S2 ;
input  S1S2mux ;
input  newDist ;
output [7:0] Accumulate ;
output [7:0] Rpipe ;

wire [7:0] AccumulateIn ;
wire [7:0] difference ;

PE_14_DW01_add_0 add_56 (
    .A ( { 1'b0 , Accumulate[7] , Accumulate[6] , Accumulate[5] , 
        Accumulate[4] , Accumulate[3] , Accumulate[2] , Accumulate[1] , 
        Accumulate[0] } ) ,
    .B ( { 1'b0 , difference[7] , difference[6] , difference[5] , 
        difference[4] , difference[3] , difference[2] , difference[1] , 
        difference[0] } ) ,
    .CI ( 1'b0 ) ,
    .SUM ( { Carry , N33 , N32 , N31 , N30 , N29 , N28 , N27 , N26 } ) ) ;
PE_14_DW01_sub_1 sub_50 ( .A ( R ) ,
    .B ( { N15 , N14 , N13 , N12 , N11 , N10 , N9 , N8 } ) ,
    .CI ( 1'b0 ) , .DIFF ( difference ) ) ;
DFFX1_LVT \Accumulate_reg[0] ( .D ( AccumulateIn[0] ) , .CLK ( clock ) , 
    .Q ( Accumulate[0] ) ) ;
DFFX1_LVT \Rpipe_reg[7] ( .D ( R[7] ) , .CLK ( clock ) , .Q ( Rpipe[7] ) ) ;
DFFX1_LVT \Rpipe_reg[6] ( .D ( R[6] ) , .CLK ( clock ) , .Q ( Rpipe[6] ) ) ;
DFFX1_LVT \Rpipe_reg[5] ( .D ( R[5] ) , .CLK ( clock ) , .Q ( Rpipe[5] ) ) ;
DFFX1_LVT \Rpipe_reg[4] ( .D ( R[4] ) , .CLK ( clock ) , .Q ( Rpipe[4] ) ) ;
DFFX1_LVT \Rpipe_reg[3] ( .D ( R[3] ) , .CLK ( clock ) , .Q ( Rpipe[3] ) ) ;
DFFX1_LVT \Rpipe_reg[2] ( .D ( R[2] ) , .CLK ( clock ) , .Q ( Rpipe[2] ) ) ;
DFFX1_LVT \Rpipe_reg[1] ( .D ( R[1] ) , .CLK ( clock ) , .Q ( Rpipe[1] ) ) ;
DFFX1_LVT \Accumulate_reg[7] ( .D ( AccumulateIn[7] ) , .CLK ( clock ) , 
    .Q ( Accumulate[7] ) ) ;
DFFX1_LVT \Accumulate_reg[6] ( .D ( AccumulateIn[6] ) , .CLK ( clock ) , 
    .Q ( Accumulate[6] ) ) ;
DFFX1_LVT \Accumulate_reg[5] ( .D ( AccumulateIn[5] ) , .CLK ( clock ) , 
    .Q ( Accumulate[5] ) ) ;
DFFX1_LVT \Accumulate_reg[4] ( .D ( AccumulateIn[4] ) , .CLK ( clock ) , 
    .Q ( Accumulate[4] ) ) ;
DFFX1_LVT \Accumulate_reg[3] ( .D ( AccumulateIn[3] ) , .CLK ( clock ) , 
    .Q ( Accumulate[3] ) ) ;
DFFX1_LVT \Accumulate_reg[2] ( .D ( AccumulateIn[2] ) , .CLK ( clock ) , 
    .Q ( Accumulate[2] ) ) ;
DFFX1_LVT \Accumulate_reg[1] ( .D ( AccumulateIn[1] ) , .CLK ( clock ) , 
    .Q ( Accumulate[1] ) ) ;
DFFX1_LVT \Rpipe_reg[0] ( .D ( R[0] ) , .CLK ( clock ) , .Q ( Rpipe[0] ) ) ;
INVX1_LVT U5 ( .A ( newDist ) , .Y ( n8 ) ) ;
INVX1_LVT U6 ( .A ( S1S2mux ) , .Y ( n9 ) ) ;
AO221X1_LVT U7 ( .A1 ( N27 ) , .A2 ( n8 ) , .A3 ( difference[1] ) , 
    .A4 ( newDist ) , .A5 ( n23 ) , .Y ( AccumulateIn[1] ) ) ;
AO221X1_LVT U8 ( .A1 ( N28 ) , .A2 ( n8 ) , .A3 ( difference[2] ) , 
    .A4 ( newDist ) , .A5 ( n23 ) , .Y ( AccumulateIn[2] ) ) ;
AO221X1_LVT U9 ( .A1 ( N29 ) , .A2 ( n8 ) , .A3 ( difference[3] ) , 
    .A4 ( newDist ) , .A5 ( n23 ) , .Y ( AccumulateIn[3] ) ) ;
AO221X1_LVT U10 ( .A1 ( N30 ) , .A2 ( n8 ) , .A3 ( difference[4] ) , 
    .A4 ( newDist ) , .A5 ( n23 ) , .Y ( AccumulateIn[4] ) ) ;
AO221X1_LVT U11 ( .A1 ( N31 ) , .A2 ( n8 ) , .A3 ( difference[5] ) , 
    .A4 ( newDist ) , .A5 ( n23 ) , .Y ( AccumulateIn[5] ) ) ;
AO221X1_LVT U12 ( .A1 ( N32 ) , .A2 ( n8 ) , .A3 ( difference[6] ) , 
    .A4 ( newDist ) , .A5 ( n23 ) , .Y ( AccumulateIn[6] ) ) ;
AO221X1_LVT U13 ( .A1 ( N33 ) , .A2 ( n8 ) , .A3 ( newDist ) , 
    .A4 ( difference[7] ) , .A5 ( n23 ) , .Y ( AccumulateIn[7] ) ) ;
AND2X1_LVT U14 ( .A1 ( Carry ) , .A2 ( n8 ) , .Y ( n23 ) ) ;
AO22X1_LVT U15 ( .A1 ( S1[0] ) , .A2 ( S1S2mux ) , .A3 ( S2[0] ) , 
    .A4 ( n9 ) , .Y ( N8 ) ) ;
AO22X1_LVT U16 ( .A1 ( S1[1] ) , .A2 ( S1S2mux ) , .A3 ( S2[1] ) , 
    .A4 ( n9 ) , .Y ( N9 ) ) ;
AO22X1_LVT U17 ( .A1 ( S1[2] ) , .A2 ( S1S2mux ) , .A3 ( S2[2] ) , 
    .A4 ( n9 ) , .Y ( N10 ) ) ;
AO22X1_LVT U18 ( .A1 ( S1[3] ) , .A2 ( S1S2mux ) , .A3 ( S2[3] ) , 
    .A4 ( n9 ) , .Y ( N11 ) ) ;
AO22X1_LVT U19 ( .A1 ( S1[4] ) , .A2 ( S1S2mux ) , .A3 ( S2[4] ) , 
    .A4 ( n9 ) , .Y ( N12 ) ) ;
AO22X1_LVT U20 ( .A1 ( S1[5] ) , .A2 ( S1S2mux ) , .A3 ( S2[5] ) , 
    .A4 ( n9 ) , .Y ( N13 ) ) ;
AO22X1_LVT U21 ( .A1 ( S1[6] ) , .A2 ( S1S2mux ) , .A3 ( S2[6] ) , 
    .A4 ( n9 ) , .Y ( N14 ) ) ;
AO22X1_LVT U22 ( .A1 ( S1[7] ) , .A2 ( S1S2mux ) , .A3 ( S2[7] ) , 
    .A4 ( n9 ) , .Y ( N15 ) ) ;
AO221X1_LVT U23 ( .A1 ( N26 ) , .A2 ( n8 ) , .A3 ( difference[0] ) , 
    .A4 ( newDist ) , .A5 ( n23 ) , .Y ( AccumulateIn[0] ) ) ;
endmodule
