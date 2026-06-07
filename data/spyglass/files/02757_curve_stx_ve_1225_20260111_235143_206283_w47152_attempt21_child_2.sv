module curve_stx_ve_1225_20260111_235143_206283_w47152_attempt21 (
  input logic [63:0] my_time_port
);
  // SpyGlass W240: Input 'my_time_port[63:0]' declared but not read.
  // Adding dummy logic to read the input port to resolve the violation.
  wire [63:0] dummy_read_my_time_port; 
  assign dummy_read_my_time_port = my_time_port;
endmodule
