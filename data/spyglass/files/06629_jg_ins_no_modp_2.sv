interface another_interface;
  logic clk;
  logic reset;
  modport controller (output clk, output reset);
  modport peripheral (input clk, input reset);
endinterface

module test_module(
  input sys_clk
);
  another_interface intf_obj(); // Violates INS_NO_MODP: no modport specified

  // Example usage
  assign intf_obj.clk = sys_clk;
  assign intf_obj.reset = 1'b0;

endmodule
