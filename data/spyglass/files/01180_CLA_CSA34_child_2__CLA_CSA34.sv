module CLA_CSA34( Genbus, Propbus, Cin,
		  LocalCarryCin0, LocalCarryCin1, CarryOutbus, Cout1, Cout2);

   input [33:0]	 Genbus, Propbus;
   input	 Cin;
   output [33:0] LocalCarryCin0, LocalCarryCin1;
   output [33:0] CarryOutbus;
   output	 Cout1, Cout2;

   /* This 34-bit adder is partitioned into blocks of sizes 5, 4 and 2.
    * Block boundaries:
    *      block #0 (5): bits [4:0]
    *      block #1 (4): bits [8:5]
    *      block #2 (5): bits [13:9]
    *      block #3 (4): bits [17:14]
    *      block #4 (5): bits [22:18]
    *      block #5 (4): bits [26:23]
    *      block #6 (5): bits [31:27] 
    *      block #7 (2): bits [33:32]

    * first calculate carries local to each block
    - note: LocalCin0[j] means the carry OUT OF bit j (to bit j+1)
    assuming the carry into that block=0
    and LocalCin1[j] means the carry OUT OF bit j (to bit j+1)
    assuming the carry into that block=1
    */

   GenLocalCarry34 CC_0( Genbus, Propbus, LocalCarryCin0, LocalCarryCin1 );

   // then generate global carry lines
   //  ... but carries are not explicitly generated for 4-bit blocks.


   GenerateGlobalCarry34 CC_1( Genbus, Propbus, Cin, LocalCarryCin0, LocalCarryCin1,
			       CarryOutbus );

   assign Cout1 = CarryOutbus[33];

   Mux2_1 CC_2( LocalCarryCin0[33], LocalCarryCin1[33], CarryOutbus[31],
		Cout2 );


endmodule
