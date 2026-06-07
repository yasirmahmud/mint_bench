control ctl_u(clock, start, S1S2mux, newDist, CompStart, PEready, VectorX, VectorY, AddressR, AddressS1, AddressS2);

  (* blackbox *)
  module PEtotal(clock, R, S1, S2, S1S2mux, newDist, Accumulate);
    input clock;
    input [7:0] R, S1, S2;
    output [15:0] S1S2mux, newDist;
    output [127:0] Accumulate;
  endmodule
