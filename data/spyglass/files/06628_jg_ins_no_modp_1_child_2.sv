interface my_interface;
  logic data;
  modport master (output data);
  modport slave (input data);
endinterface

module top_module(
  input clk
);
  my_interface if_inst(); // Fixed: Corrected instantiation syntax to resolve STX_VE_481

  // Example usage (not directly related to the violation, but shows context)
  assign if_inst.data = clk;

endmodule
