module curve_wrn_66_20260110_222144_attempt2;

  // Declare two 32-bit wires to match the assumed width of 0'd0
  wire [31:0] first_data_value;
  wire [31:0] second_data_value;

  // Assign a zero-width based number, triggering WRN_66 #1
  assign first_data_value = 32'd0;

  // Assign another zero-width based number, triggering WRN_66 #2
  assign second_data_value = 32'd0;

endmodule
