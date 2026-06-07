module analog_cell_lib (input ana_pin);
  // SpyGlass W240 fix: Dummy read to prevent 'input not read' warning
  wire unused_ana_pin = ana_pin;
endmodule
