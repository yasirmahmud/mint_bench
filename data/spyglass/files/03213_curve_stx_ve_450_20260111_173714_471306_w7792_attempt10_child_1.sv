module curve_stx_ve_450_20260111_173714_471306_w7792_attempt10;

  // STX_VE_450: This 'typedef struct packed' contains an unpacked member 'sensor_readings'.
  // Note: 'typedef struct' is a SystemVerilog construct. This example uses it to trigger
  // the STX_VE_450 rule, as Verilog-2001 does not strictly support structures. SpyGlass
  // often processes SystemVerilog constructs in this context.
  typedef struct packed {
    reg [7:0] packet_id;
    reg [15:0] timestamp;
    reg [7:0] [7:0] sensor_readings; // Changed to a packed array to resolve STX_VE_450
    reg [7:0] checksum;
  } sensor_data_packet_t;

  sensor_data_packet_t my_sensor_packet;

  initial begin
    my_sensor_packet.packet_id = 8'h01;
    my_sensor_packet.timestamp = 16'hFEED;
    my_sensor_packet.sensor_readings[0] = 8'h10;
    my_sensor_packet.sensor_readings[1] = 8'h20;
    my_sensor_packet.sensor_readings[7] = 8'hFF;
    my_sensor_packet.checksum = 8'hEE;

    $display("Packet ID: %h", my_sensor_packet.packet_id);
    $display("Timestamp: %h", my_sensor_packet.timestamp);
    $display("Sensor Reading[0]: %h", my_sensor_packet.sensor_readings[0]);
    $display("Checksum: %h", my_sensor_packet.checksum);
  end

endmodule
