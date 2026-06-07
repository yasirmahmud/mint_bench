module curve_stx_ve_449_20260111_214517_259860_w28836_attempt13 ();

  // STX_VE_449 violation: The enumeration range is 1-bit ([0:0]),
  // but the explicitly assigned value for MY_STATE_INVALID (2'b10 = 2) is more than the range specified for the enumeration.
  typedef enum logic [0:0] { // 1-bit range, allows values 0 and 1
    MY_STATE_IDLE    = 1'b0,  // Value 0 (fits in 1-bit)
    MY_STATE_ACTIVE  = 1'b1,  // Value 1 (fits in 1-bit)
    MY_STATE_INVALID = 2'b10  // Value 2 (explicitly assigned, requires 2 bits, violates 1-bit range)
  } custom_state_type;

  custom_state_type my_current_state; // Declare a variable of the enum type to prevent unused type warnings

  initial begin
    my_current_state = MY_STATE_IDLE; // Assign an initial state to prevent unused signal warnings
    $display("Current state: %s (value %0d)", my_current_state.name(), my_current_state);
  end

endmodule
