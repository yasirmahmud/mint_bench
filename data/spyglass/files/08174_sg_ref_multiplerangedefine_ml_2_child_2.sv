module MultipleRangeDefine_ex2 (input [7:0] my_port);
  // To resolve W240: Input 'my_port[7:0]' declared but not read, we'll read it into a dummy wire.
  wire [7:0] dummy_read;
  assign dummy_read = my_port;
 endmodule
