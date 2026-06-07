module curve_stx_ve_450_20260111_173714_471306_w7792_attempt8;

  // STX_VE_450: This 'typedef struct packed' contains an unpacked member 'unpacked_array_member'.
  // Note: 'typedef struct' is a SystemVerilog construct. This example uses it to trigger
  // the STX_VE_450 rule, as Verilog-2001 does not support structures.
  typedef struct packed {
    // Changed unpacked array to a packed vector to resolve STX_VE_450 violation.
    // The original `reg [7:0] unpacked_array_member[8];` was an unpacked array of 8-bit elements.
    // It is now represented as a single 64-bit packed vector (8 elements * 8 bits/element).
    reg [63:0] unpacked_array_member;
    reg [31:0] status_word;
  } control_packet_t;

  control_packet_t my_packet;

  initial begin
    // Accesses to 'unpacked_array_member' must now use bit-slicing to maintain functional behavior.
    // Original: my_packet.unpacked_array_member[0] = 8'hAA;
    my_packet.unpacked_array_member[7:0] = 8'hAA; // Element 0 corresponds to bits [7:0]
    // Original: my_packet.unpacked_array_member[7] = 8'h55;
    my_packet.unpacked_array_member[63:56] = 8'h55; // Element 7 corresponds to bits [63:56]
    my_packet.status_word = 32'hFEEDFACE;
    // Original: $display("Packet array[0]: %h", my_packet.unpacked_array_member[0]);
    $display("Packet array[0]: %h", my_packet.unpacked_array_member[7:0]);
    $display("Packet Status: %h", my_packet.status_word);
  end

endmodule
