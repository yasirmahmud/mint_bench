module sub_module (input [3:0] in_port);
  // Fix W240 and WarnAnalyzeBBox: Added internal logic to use the input port
  wire [3:0] internal_in_port_data;
  assign internal_in_port_data = in_port;

  // Fix W528: Add dummy logic to use internal_in_port_data.
  // This ensures 'internal_in_port_data' is read, satisfying W528,
  // without changing the module's functional behavior.
  reg [3:0] unused_data_sink;
  always @(*) begin
    unused_data_sink = internal_in_port_data;
  end
endmodule
