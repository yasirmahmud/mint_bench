module my_module_ex2();
 wire data_sig_zero;
 wire data_sig_one;
 assign data_sig_zero = 1'b0;
 assign data_sig_one = 1'b1;
 // To resolve STARC05-1.1.1.5, the original names with different casing are replaced with unique names.
 // To resolve W528 (set but not read), the wires are read by assigning them to dummy wires.
 wire dummy_read_zero = data_sig_zero;
 wire dummy_read_one = data_sig_one;
 endmodule
