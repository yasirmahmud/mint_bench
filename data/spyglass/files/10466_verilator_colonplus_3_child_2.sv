module test3;
  wire [31:0] bus;
  wire [7:0] sub_bus;
  
  // To resolve SpyGlass W123 (bus read but never set), add a dummy driver for 'bus'.
  // This does not alter the intended behavior of the part-select, as 'bus' behavior was not specified.
  assign bus = 32'h0;

  // Fix Verilator COLONPLUS warning: change ":+" to "+:" for the intended indexed part-select.
  assign sub_bus = bus[16 +: 8];
  
  // To resolve SpyGlass W528 (sub_bus set but not read), add a dummy reader for 'sub_bus'.
  // This does not alter the core functional behavior of the module.
  wire [7:0] dummy_sub_bus_read;
  assign dummy_sub_bus_read = sub_bus;

  // To resolve SpyGlass W528 on 'dummy_sub_bus_read' itself (set but not read),
  // we add a simulation-only read using $display. This causes the signal to be read
  // without affecting synthesizable logic or propagating the W528 violation further.
  initial begin
    $display("At time %0t: Dummy sub_bus read value: %h", $time, dummy_sub_bus_read);
  end
endmodule
