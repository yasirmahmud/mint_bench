interface synth5245_md_if;
  logic signal_a;
endinterface

module curve_synth_5245_top;
  // SYNTH_5245: Instantiating a multi-dimensional array of interfaces is an unsupported SystemVerilog construct.
  // This line triggers the SYNTH_5245 violation because it declares a two-dimensional array of interfaces.
  synth5245_md_if if_instances [0:1][0:1] (); // A 2x2 two-dimensional array of interfaces

endmodule
