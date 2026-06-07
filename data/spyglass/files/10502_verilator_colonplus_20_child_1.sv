module test20;
  logic [127:0] data_stream;
  logic [7:0] packet_header;
  assign packet_header = data_stream[0 +: 8];
endmodule
