module tristate_ex2;
 wire out_wire;
 reg enable;
 reg data;
 assign out_wire = enable ? data : 1'bz;
 endmodule
