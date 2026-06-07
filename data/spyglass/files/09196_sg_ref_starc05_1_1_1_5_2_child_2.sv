module my_module_ex2();
 wire data_sig_zero;
 wire data_sig_one;
 assign data_sig_zero = 1'b0;
 assign data_sig_one = 1'b1;
 // To resolve STARC05-1.1.1.5, the original names with different casing are replaced with unique names.
 // The previous attempt to resolve W528 by assigning to dummy wires introduced new W528 violations for the dummy wires themselves.
 // Since 'dummy_read_zero' and 'dummy_read_one' serve no functional purpose and are not read, they are removed to resolve the reported W528 violations.
 endmodule
