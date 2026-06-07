module curve_stx_ve_462_20260111_034555_attempt5 (
  output wire [7:0] out_data
);

  // Declare an unpacked array of two 8-bit wires
  wire [7:0] my_unpacked_wires [0:1];

  // STX_VE_462 Violation:
  // An illegal assignment is attempted here. A replication of a 1-bit constant
  // ({16{1'b1}} creating a single 16-bit packed vector) is directly assigned
  // to 'my_unpacked_wires', which is an unpacked array of two 8-bit wires.
  // Verilog-2001 does not permit this direct assignment from a packed value
  // to an unpacked array without an assignment pattern (SystemVerilog feature).
  assign my_unpacked_wires = {16{1'b1}}; // FATAL: STX_VE_462 triggers here

  // Ensure my_unpacked_wires is used to avoid unused wire warnings
  assign out_data = my_unpacked_wires[0] + my_unpacked_wires[1];

endmodule
