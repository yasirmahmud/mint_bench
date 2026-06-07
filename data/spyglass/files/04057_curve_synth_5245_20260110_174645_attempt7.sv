interface my_if_type;
  logic data_signal;
endinterface

module top_module_SYNTH_5245;
  // SYNTH_5245: Multi-Dimensional Array Of Interfaces is an unsupported SystemVerilog construct in a Verilog-2001 synthesis context.
  my_if_type if_instance [0:1][0:2] ();
endmodule
