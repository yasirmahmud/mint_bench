module PEtotal (clock, R, S1, S2, S1S2mux, newDist, Accumulate);
  input clock;
  input [7:0] R, S1, S2; // memory inputs
  input [15:0] S1S2mux, newDist; // control input
  output [127:0] Accumulate;

  wire [7:0] Rpipe0, Rpipe1, Rpipe2, Rpipe3, Rpipe4, Rpipe5, Rpipe6, Rpipe7, Rpipe8, Rpipe9, Rpipe10, Rpipe11, Rpipe12, Rpipe13, Rpipe14;

  PE pe0 (clock, R, S1, S2, S1S2mux[0], newDist[0], Accumulate[7:0], Rpipe0);

  PE pe1 (clock, Rpipe0, S1, S2, S1S2mux[1], newDist[1], Accumulate[15:8], Rpipe1);

  PE pe2 (clock, Rpipe1, S1, S2, S1S2mux[2], newDist[2], Accumulate[23:16], Rpipe2);

  PE pe3 (clock, Rpipe2, S1, S2, S1S2mux[3], newDist[3], Accumulate[31:24], Rpipe3);

  PE pe4 (clock, Rpipe3, S1, S2, S1S2mux[4], newDist[4], Accumulate[39:32], Rpipe4);

  PE pe5 (clock, Rpipe4, S1, S2, S1S2mux[5], newDist[5], Accumulate[47:40], Rpipe5);

  PE pe6 (clock, Rpipe5, S1, S2, S1S2mux[6], newDist[6], Accumulate[55:48], Rpipe6);

  PE pe7 (clock, Rpipe6, S1, S2, S1S2mux[7], newDist[7], Accumulate[63:56], Rpipe7);

  PE pe8 (clock, Rpipe7, S1, S2, S1S2mux[8], newDist[8], Accumulate[71:64], Rpipe8);

  PE pe9 (clock, Rpipe8, S1, S2, S1S2mux[9], newDist[9], Accumulate[79:72], Rpipe9);

  PE pe10 (clock, Rpipe9, S1, S2, S1S2mux[10], newDist[10], Accumulate[87:80], Rpipe10);

  PE pe11 (clock, Rpipe10, S1, S2, S1S2mux[11], newDist[11], Accumulate[95:88], Rpipe11);

  PE pe12 (clock, Rpipe11, S1, S2, S1S2mux[12], newDist[12], Accumulate[103:96], Rpipe12);

  PE pe13 (clock, Rpipe12, S1, S2, S1S2mux[13], newDist[13], Accumulate[111:104], Rpipe13);

  PE pe14 (clock, Rpipe13, S1, S2, S1S2mux[14], newDist[14], Accumulate[119:112], Rpipe14);

  PEend pe15 (clock, Rpipe14, S1, S2, S1S2mux[15], newDist[15], Accumulate[127:120]);
endmodule
