module curve_stx_ve_450_20260111_214539_170227_w49296_attempt11 ();

  // STX_VE_450: Unpacked member ( data ) found in packed structure
  // This rule is triggered by including an unpacked array 'data_payload' 
  // within a 'typedef struct packed' definition.
  typedef struct packed {
    reg [7:0] header;          // Packed member
    reg [15:0] data_payload[4]; // Unpacked array, triggers STX_VE_450
    reg [7:0] footer;          // Packed member
  } my_packet_t;

  // Instantiate the structure to avoid potential unused type warnings.
  my_packet_t packet_instance;

  // Simple initial block to use some members and prevent unused signal warnings.
  initial begin
    packet_instance.header = 8'hA5;
    packet_instance.footer = 8'h5A;
    // No need to assign to data_payload as its declaration is the violation.
  end

endmodule
