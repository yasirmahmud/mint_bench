module curve_stx_ve_450_20260110_114643_attempt4;

  // STX_VE_450: Unpacked member (packet_data_blocks) found in packed structure
  // This typedef defines a packed structure 'network_packet_t' (using 'packed' keyword).
  // It contains an unpacked array 'packet_data_blocks' (declared as reg [63:0] packet_data_blocks[0:1]).
  // The presence of an unpacked array member ('packet_data_blocks') within a packed structure definition
  // is the direct cause of the STX_VE_450 violation.
  typedef struct packed {
    reg [7:0] header_version;
    reg [15:0] payload_length;
    reg [1:0][63:0] packet_data_blocks; // Changed to a packed array to resolve STX_VE_450 violation
    reg [31:0] checksum;
  } network_packet_t;

  // Declare an instance of the struct to ensure the typedef is used
  // and to avoid potential 'unused type' or 'unused signal' warnings.
  network_packet_t my_packet;

  // Simple initial block to assign values to the struct members.
  // This avoids unused signal warnings and provides minimal functionality.
  initial begin
    my_packet.header_version = 8'h01;
    my_packet.payload_length = 16'h0010;
    my_packet.packet_data_blocks[0] = 64'hAABBCCDD11223344;
    my_packet.packet_data_blocks[1] = 64'hEEFF001155667788;
    my_packet.checksum = 32'hFEEDFACE;
  end

endmodule
