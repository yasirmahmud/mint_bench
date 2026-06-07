module no_ports_module_2;
  // This module has no port declarations,
  // even though it has internal logic.
  wire internal_wire;
  assign internal_wire = 1'b0;
endmodule
