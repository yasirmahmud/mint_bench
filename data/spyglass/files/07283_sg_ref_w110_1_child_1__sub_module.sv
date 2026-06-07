module sub_module (input [3:0] in_port);
  // Fix W240 and WarnAnalyzeBBox: Added internal logic to use the input port
  wire [3:0] internal_in_port_data;
  assign internal_in_port_data = in_port;
endmodule
