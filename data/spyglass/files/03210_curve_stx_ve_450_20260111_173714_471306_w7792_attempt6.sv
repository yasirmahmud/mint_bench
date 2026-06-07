module curve_stx_ve_450_20260111_173714_471306_w7792_attempt6;

  // STX_VE_450: This 'typedef struct packed' contains an unpacked member 'values'.
  // Verilog-2001 does not inherently support 'typedef struct'. This example
  // leverages SystemVerilog's 'typedef struct packed' to demonstrate the rule,
  // while using Verilog-2001 compatible syntax for other parts of the module.
  typedef struct packed {
    reg [15:0] id;
    reg [7:0] values[10]; // This is the unpacked member triggering the violation
    reg enable;
  } my_packet_t;

  my_packet_t packet_data;

  initial begin
    packet_data.id = 16'hFEED;
    // Assigning to individual elements to avoid implicit array assignment issues in Verilog-2001 contexts
    packet_data.values[0] = 8'h11;
    packet_data.values[1] = 8'h22;
    packet_data.values[2] = 8'h33;
    packet_data.values[3] = 8'h44;
    packet_data.values[4] = 8'h55;
    packet_data.values[5] = 8'h66;
    packet_data.values[6] = 8'h77;
    packet_data.values[7] = 8'h88;
    packet_data.values[8] = 8'h99;
    packet_data.values[9] = 8'hAA;
    packet_data.enable = 1'b1;

    $display("Packet ID: %h, First Value: %h, Enable: %b", packet_data.id, packet_data.values[0], packet_data.enable);
  end

endmodule
