module curve_stx_ve_450_20260111_173714_471306_w7792_attempt6;

  // STX_VE_450: This 'typedef struct packed' contains an unpacked member 'values'.
  // Verilog-2001 does not inherently support 'typedef struct'. This example
  // leverages SystemVerilog's 'typedef struct packed' to demonstrate the rule,
  // while using Verilog-2001 compatible syntax for other parts of the module.
  typedef struct packed {
    reg [15:0] id;
    // Original: reg [7:0] values[10]; // This was the unpacked member triggering the violation
    // Fix: Make 'values' a packed vector to comply with 'packed struct' rules.
    reg [79:0] values; // 10 elements * 8 bits/element = 80 bits
    reg enable;
  } my_packet_t;

  my_packet_t packet_data;

  initial begin
    packet_data.id = 16'hFEED;
    // Assigning to individual elements to avoid implicit array assignment issues in Verilog-2001 contexts
    // Adjust assignments for the now packed 'values' member using bit-slicing.
    packet_data.values[7:0] = 8'h11;
    packet_data.values[15:8] = 8'h22;
    packet_data.values[23:16] = 8'h33;
    packet_data.values[31:24] = 8'h44;
    packet_data.values[39:32] = 8'h55;
    packet_data.values[47:40] = 8'h66;
    packet_data.values[55:48] = 8'h77;
    packet_data.values[63:56] = 8'h88;
    packet_data.values[71:64] = 8'h99;
    packet_data.values[79:72] = 8'hAA;
    packet_data.enable = 1'b1;

    // Adjust display statement to access the first 8-bit value from the packed 'values' member.
    $display("Packet ID: %h, First Value: %h, Enable: %b", packet_data.id, packet_data.values[7:0], packet_data.enable);
  end

endmodule
