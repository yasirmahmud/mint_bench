module GenLocalCarry9( Gbus, Pbus, LocalC0, LocalC1 );

   input [8:0]	Gbus, Pbus;
   output [8:0]	LocalC0, LocalC1;

   GenLocalCarry5 GLC9_0( Gbus[4:0], Pbus[4:0],
			  LocalC0[4:0], LocalC1[4:0] );
   GenLocalCarry4 GLC9_4( Gbus[8:5], Pbus[8:5],
			  LocalC0[8:5], LocalC1[8:5] );

endmodule
