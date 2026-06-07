interface my_synth_if_type;
  logic data_signal;
endinterface

module curve_synth_5245_top_module;
  // SYNTH_5245: Instantiating a multi-dimensional array of interfaces is an unsupported SystemVerilog construct in a Verilog-2001 synthesis context.
  // This line triggers the SYNTH_5245 violation by declaring a three-dimensional array of interfaces.
  my_synth_if_type my_interface_array [0:0][0:1][0:0] (); // A 1x2x1 three-dimensional array of interfaces

endmodule
