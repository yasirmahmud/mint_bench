interface my_bus_if;
  logic clk;
  logic rst_n;
  logic [7:0] data_in;
  logic [7:0] data_out;
endinterface

module curve_stx_ve_1232_20260111_184210_334415_w47100_attempt6;
  // STX_VE_1232: 'my_bus_if' is used as an interface type for an array,
  // but 'my_bus_if' is not declared as an interface in this scope or any included file.
  // FIX: Added a basic 'my_bus_if' interface declaration to resolve the undeclared type error.
  my_bus_if bus_insts[3];
endmodule
