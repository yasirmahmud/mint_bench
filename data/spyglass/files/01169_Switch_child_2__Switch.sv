module Switch (clock, start, BestDist, motionX, motionY,R, S1, S2,AddressR, AddressS1, AddressS2);
  input clock;
  input start;
  output [7:0] BestDist;
  output [3:0] motionX, motionY;
  input [7:0] R, S1, S2;
  input [7:0] AddressR;
  input [9:0]AddressS1, AddressS2;
  
  wire clock;
  wire start;
  wire [7:0] BestDist;
  wire [3:0] motionX, motionY;

  wire [7:0] R, S1, S2;
  wire [7:0] AddressR;
  wire [9:0] AddressS1, AddressS2;

  wire [15:0] S1S2mux, newDist, PEready;
  wire CompStart;
  wire [3:0] VectorX, VectorY;
  wire [127:0] Accumulate;
  wire [7:0] Rpipe;

  control ctl_u(clock, start, S1S2mux, newDist, CompStart, PEready, VectorX, VectorY, AddressR, AddressS1, AddressS2);

  PEtotal pe_u(clock, R, S1, S2, S1S2mux, newDist, Accumulate);

  Comparator comp_u(clock, CompStart, Accumulate, PEready, VectorX, VectorY, BestDist, motionX, motionY);
endmodule
