package my_pkg;
  // STX_VE_1266: Implicit continuous assignment is not allowed within package
  // Changed 'wire' to 'parameter' to define a constant value, which is appropriate for package scope
  parameter [7:0] cfg_data_bus = 8'h55;
endpackage

module top_module;
  // A minimal module to make the file a valid Verilog design.
  // This module itself does not contain any violations.
  initial begin
    $display("Hello from top_module");
  end
endmodule
