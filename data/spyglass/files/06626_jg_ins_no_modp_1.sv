interface my_interface;
  logic data;
  modport master (output data);
  modport slave (input data);
endinterface

module top_module(
  input clk
);
  my_interface if_inst(); // Violates INS_NO_MODP: no modport specified

  // Example usage (not directly related to the violation, but shows context)
  assign if_inst.data = clk;

endmodule
