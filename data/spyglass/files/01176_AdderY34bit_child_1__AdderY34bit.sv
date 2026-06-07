module AdderY34bit( YAbus, YBbus, CinY, CoutY1, CoutY2, CoutY_17 );

   input [33:0]	YAbus, YBbus;
   input	CinY;
   output	CoutY1, CoutY2, CoutY_17;

   wire [33:0]	GenYbus, PropYbus;
   wire [33:0]	CarryOutYbus;
   wire [33:0]	dummy0, dummy1;

   GenProp34 UM8_0( YAbus, YBbus, GenYbus, PropYbus);

   CLA_CSA34 UM8_1( .Genbus(GenYbus), .Propbus(PropYbus), .Cin(CinY),
		    .LocalCarryCin0(dummy0), .LocalCarryCin1(dummy1),
		    .CarryOutbus(CarryOutYbus), .Cout1(CoutY1), .Cout2(CoutY2) );

   assign CoutY_17 = CarryOutYbus[17];

endmodule
