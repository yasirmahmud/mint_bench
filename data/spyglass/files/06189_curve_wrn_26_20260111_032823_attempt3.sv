`define MY_SETTING 50 // Initial definition of the macro

module curve_wrn_26_20260111_032823_attempt3 ();

  // This redefinition of MY_SETTING will trigger WRN_26
  `define MY_SETTING 100

  // Declare a wire to use the redefined macro value
  // This avoids unused signal warnings and ensures a synthesizable context.
  wire [7:0] calculated_value;
  
  assign calculated_value = `MY_SETTING; // Using the redefined macro value

endmodule
