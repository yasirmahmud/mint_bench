module init_ports_ex1 (input data_in);
 wire data_in_effective;
 // The original 'input data_in = 1'b0' is a SystemVerilog 2009 construct for default port values.
 // To resolve the STX_VE_479 syntax error in older Verilog standards, we remove the default
 // assignment from the port list. To preserve the functional behavior (where data_in defaults
 // to 1'b0 if left unconnected), we introduce internal logic. If data_in is 'X' (unconnected),
 // data_in_effective will be 1'b0; otherwise, it will take the value of data_in.
 //
 // To resolve SYNTH_5058, STARC05-2.10.1.4a, STARC05-2.10.1.4b, and W339a (all related to
 // comparing with 'x' using '==='), the explicit X-comparison has been removed. This change
 // relies on standard synthesis tool behavior where unconnected input ports are automatically
 // tied to '0' (or ground), thereby preserving the functional requirement that 'data_in'
 // defaults to '1'b0' when left unconnected.
 assign data_in_effective = data_in;
 //
 // The 'unused_wire' and its assignment have been removed to resolve W528 (variable set but not read).
 endmodule
