interface my_interface;
  // No members are defined to avoid potential unused signal warnings within the interface.
endinterface

module top_module;
  // SYNTH_5245: Synthesis failed for the module since it has unsupported System Verilog constructs Multi-Dimensional Array Of Interfaces.
  // This line declares a multi-dimensional array of interfaces, which is the direct trigger for SYNTH_5245.
  my_interface if_array [0:1][0:1] ();

  // No other logic is included to ensure minimality and avoid unrelated violations.
endmodule
