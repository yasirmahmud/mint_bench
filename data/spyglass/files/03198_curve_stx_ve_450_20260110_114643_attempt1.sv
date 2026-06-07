module curve_stx_ve_450_20260110_114643_attempt1;

  // STX_VE_450: Unpacked member (data) found in packed structure
  // This typedef defines a packed structure (using 'packed' keyword)
  // that contains an unpacked array 'data' (declared as reg [7:0] data[3:0]).
  // The presence of an unpacked member ('data') within a packed structure definition
  // is the direct cause of the STX_VE_450 violation.
  typedef struct packed {
    reg [7:0] data[3:0]; // Unpacked array member within a packed structure. This triggers the rule.
    reg [31:0] control;
  } my_data_t;

  // Declare an instance of the struct to ensure the typedef is used
  // and to avoid potential 'unused type' or 'unused signal' warnings.
  my_data_t my_instance;

  // Simple combinational logic to assign values to the struct members.
  // This avoids unused signal warnings and provides minimal functionality.
  always @* begin
    my_instance.control = 32'h12345678;
    my_instance.data[0] = 8'hAA;
    my_instance.data[1] = 8'hBB;
    my_instance.data[2] = 8'hCC;
    my_instance.data[3] = 8'hDD;
  end

endmodule
