PRWDWUWSWCDGH_H IOPAD(
  .PAD(pad),
  .I(muxed_f2p),
  .OEN(io_bit),
  .ST(1'b0),
  .SL(1'b0),
  .IE(io_bit),
  .C(p2f),
  .DS0(1'b0), 
  .DS1(1'b0), 
  .DS2(1'b0),
  .PU(1'b0),
  .PD(1'b0), 
  .RTE(rte),
  .ESD(esd)
);


endmodule
