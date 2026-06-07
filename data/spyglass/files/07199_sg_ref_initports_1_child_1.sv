module init_ports_ex1 (input data_in);
 wire unused_wire;
 wire data_in_effective;
 // The original 'input data_in = 1'b0' is a SystemVerilog 2009 construct for default port values.
 // To resolve the STX_VE_479 syntax error in older Verilog standards, we remove the default
 // assignment from the port list. To preserve the functional behavior (where data_in defaults
 // to 1'b0 if left unconnected), we introduce internal logic. If data_in is 'X' (unconnected),
 // data_in_effective will be 1'b0; otherwise, it will take the value of data_in.
 assign data_in_effective = (data_in === 1'bx) ? 1'b0 : data_in;
 assign unused_wire = data_in_effective;
 endmodule
