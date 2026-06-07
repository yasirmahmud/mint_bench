package my_constants_pkg;
  // STX_VE_1266: This line declared a 16-bit wire with an implicit continuous assignment
  // directly inside a package, triggering the STX_VE_1266 rule. This is example #7.
  // To fix this, convert the 'wire' to a 'parameter' as packages are for constants,
  // types, functions, and tasks, not for instantiating wires with continuous assignments.
  parameter [15:0] status_code_wire = 16'hABCD;
endpackage

module top_module;
  // A minimal module to ensure the file is a valid Verilog design.
  // This module itself does not contain any violations.
  initial begin
    $display("Hello from top_module");
  end
endmodule
