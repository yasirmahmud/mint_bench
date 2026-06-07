interface my_interface;
  logic data;
endinterface

module top_module;
  // SYNTH_5245: Multi-Dimensional Array Of Interfaces is an unsupported SystemVerilog construct in a Verilog-2001 synthesis context.
  my_interface if_array [0:0][0:0] ();
endmodule
