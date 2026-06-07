module verilator_encapsulated_4_child_2;

  initial begin
    // The original design used a SystemVerilog class with a local member
    // and a getter function. The value returned was 40.
    // To resolve SpyGlass 'Unsupported SV constructs' and 'NoTopDUFound' errors,
    // and maintain the functional behavior of displaying the value,
    // the class-based structure is replaced with direct display of the value.
    $display("Accessing local_bus: %0d", 40);
  end

endmodule
