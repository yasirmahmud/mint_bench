module curve_stx_ve_449_20260111_214517_259860_w28836_attempt13 ();

  // STX_VE_449 violation: The enumeration range is 1-bit ([0:0]),
  // but the explicitly assigned value for MY_STATE_INVALID (2'b10 = 2) is more than the range specified for the enumeration.
  // FIX: Increased the width of the enum from [0:0] to [1:0] to accommodate the 2'b10 value.
  // STX_VE_453 violation: Size mismatch in enumeration value ( 1'b0 ) / ( 1'b1 ) for the enumerated literal MY_STATE_IDLE / MY_STATE_ACTIVE
  // FIX: Changed the width of the assigned values to match the enum's declared width [1:0].
  typedef enum logic [1:0] { // 2-bit range, allows values 0, 1, 2, 3
    MY_STATE_IDLE    = 2'b00,  // Value 0 (now 2-bit wide)
    MY_STATE_ACTIVE  = 2'b01,  // Value 1 (now 2-bit wide)
    MY_STATE_INVALID = 2'b10  // Value 2 (explicitly assigned, fits in 2-bit)
  } custom_state_type;

  custom_state_type my_current_state; // Declare a variable of the enum type to prevent unused type warnings

  initial begin
    my_current_state = MY_STATE_IDLE; // Assign an initial state to prevent unused signal warnings
    $display("Current state: %s (value %0d)", my_current_state.name(), my_current_state);
  end

endmodule
