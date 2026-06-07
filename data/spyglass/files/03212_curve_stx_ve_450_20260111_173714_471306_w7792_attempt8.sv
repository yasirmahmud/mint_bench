module curve_stx_ve_450_20260111_173714_471306_w7792_attempt8;

  // STX_VE_450: This 'typedef struct packed' contains an unpacked member 'unpacked_array_member'.
  // Note: 'typedef struct' is a SystemVerilog construct. This example uses it to trigger
  // the STX_VE_450 rule, as Verilog-2001 does not support structures.
  typedef struct packed {
    reg [7:0] unpacked_array_member[8]; // This is the unpacked member triggering the violation
    reg [31:0] status_word;
  } control_packet_t;

  control_packet_t my_packet;

  initial begin
    my_packet.unpacked_array_member[0] = 8'hAA;
    my_packet.unpacked_array_member[7] = 8'h55;
    my_packet.status_word = 32'hFEEDFACE;
    $display("Packet array[0]: %h", my_packet.unpacked_array_member[0]);
    $display("Packet Status: %h", my_packet.status_word);
  end

endmodule
