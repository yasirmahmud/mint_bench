interface my_simple_interface_synth5245;
  wire control_signal; // V2001 compatible signal type
endinterface

module target_module_SYNTH_5245 (
  // This module has no ports to minimize complexity and avoid other potential rule violations.
  // The intent is to isolate the SYNTH_5245 violation.
);

  // SYNTH_5245: This line triggers the violation.
  // Instantiating a multi-dimensional array of interfaces, 'if_md_array', is an unsupported SystemVerilog
  // construct in a Verilog-2001 synthesis context. This specific construct leads to synthesis failure.
  my_simple_interface_synth5245 if_md_array [0:0][0:2] (); // A 1x3 two-dimensional array of interfaces

endmodule
