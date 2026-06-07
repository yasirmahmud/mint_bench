module GenProp34(
   input [33:0] YAbus,
   input [33:0] YBbus,
   output [33:0] GenYbus,
   output [33:0] PropYbus
);
   assign GenYbus = YAbus & YBbus;
   assign PropYbus = YAbus ^ YBbus;
endmodule
