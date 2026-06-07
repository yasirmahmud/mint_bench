module curve_stx_ve_450_20260110_114643_attempt1;

  // STX_VE_450: Unpacked member (data) found in packed structure
  // This typedef defines a packed structure (using 'packed' keyword)
  // that contains an unpacked array 'data' (declared as reg [7:0] data[3:0]).
  // The presence of an unpacked member ('data') within a packed structure definition
  // is the direct cause of the STX_VE_450 violation.
  //
  // Resolution: Changed 'reg [7:0] data[3:0];' to 'reg [3:0][7:0] data;' to make 'data'
  // a packed array of packed vectors, thus making it a packed member compatible with a packed struct.
  typedef struct packed {
    reg [3:0][7:0] data; // Packed array of packed vectors, compatible with a packed structure.
    reg [31:0] control;
  } my_data_t;

  // Declare an instance of the struct to ensure the typedef is used
  // and to avoid potential 'unused type' or 'unused signal' warnings.
  my_data_t my_instance;

  // To resolve W528 'set but not read' warnings, add dummy reads.
  wire [31:0] dummy_read_control;
  wire [31:0] dummy_read_data;

  // Simple combinational logic to assign values to the struct members.
  // This avoids unused signal warnings and provides minimal functionality.
  always @* begin
    my_instance.control = 32'h12345678;
    my_instance.data[0] = 8'hAA;
    my_instance.data[1] = 8'hBB;
    my_instance.data[2] = 8'hCC;
    my_instance.data[3] = 8'hDD;
  end

  // Dummy reads to satisfy W528 'set but not read' violations.
  assign dummy_read_control = my_instance.control;
  assign dummy_read_data = my_instance.data;

endmodule
