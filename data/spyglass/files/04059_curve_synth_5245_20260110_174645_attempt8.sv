interface my_data_interface;
  logic data_signal;
endinterface

module target_module_SYNTH_5245;
  // SYNTH_5245: Instantiating a multi-dimensional array of interfaces is an unsupported SystemVerilog construct in a Verilog-2001 synthesis context.
  my_data_interface if_md_array [0:1][0:1][0:1] ();
endmodule
