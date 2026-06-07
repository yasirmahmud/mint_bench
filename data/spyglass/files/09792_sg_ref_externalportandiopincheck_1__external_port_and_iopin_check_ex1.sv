module external_port_and_iopin_check_ex1 (inout ext_io_port);
 wire internal_io_wire;
 MY_IO_CELL i_io_cell (.PAD(internal_io_wire));
 assign ext_io_port = internal_io_wire;
 assign internal_io_wire = ext_io_port;
 endmodule
