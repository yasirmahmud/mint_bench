module control(clock, start, S1S2mux, newDist, CompStart, PEready, VectorX, VectorY, AddressR, AddressS1, AddressS2);
    input clock, start;
    output [15:0] S1S2mux, newDist, PEready;
    output CompStart;
    output [3:0] VectorX, VectorY;
    input [7:0] AddressR;
    input [9:0] AddressS1, AddressS2;
  endmodule
