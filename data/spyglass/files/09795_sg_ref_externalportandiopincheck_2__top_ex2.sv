module top_ex2 (io_port);
 inout io_port;
 wire internal_pad_net;
 wire dummy_core_out;
 IO_CELL u_io_cell (.PAD(internal_pad_net), .CORE_IN(1'b0), .CORE_OUT(dummy_core_out));
 assign io_port = internal_pad_net;
 endmodule
