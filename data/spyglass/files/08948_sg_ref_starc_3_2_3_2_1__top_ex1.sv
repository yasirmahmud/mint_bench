module top_ex1(OUT, IN);
 output [3:0] OUT;
 input IN;
 sub_ex1 i_sub_ex1( .OUT(OUT), .IN(IN) );
 endmodule
