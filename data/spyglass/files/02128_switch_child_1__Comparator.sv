PEtotal pe_u(clock, R, S1, S2, S1S2mux, newDist, Accumulate);

  (* blackbox *)
  module Comparator(clock, CompStart, Accumulate, PEready, VectorX, VectorY, BestDist, motionX, motionY);
    input clock, CompStart;
    input [127:0] Accumulate;
    input [15:0] PEready;
    input [3:0] VectorX, VectorY;
    output [7:0] BestDist;
    output [3:0] motionX, motionY;
  endmodule
