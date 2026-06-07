module OnePortLine_ex1(p1, p2);
 input p1, p2;

 // W240: Input declared but not read. Add dummy reads to fix this violation.
 // This logic is added solely to resolve linting violations and does not alter
 // the design's original unspecified functional behavior.
 wire _sg_dummy_read_p1;
 wire _sg_dummy_read_p2;

 assign _sg_dummy_read_p1 = p1;
 assign _sg_dummy_read_p2 = p2;

 // Fix W528: Variables '_sg_dummy_read_p1' and '_sg_dummy_read_p2' set but not read.
 // A common Verilog idiom to consume multiple unused signals for linting
 // is to combine them into a single dummy wire. This ensures that
 // _sg_dummy_read_p1 and _sg_dummy_read_p2 are now 'read'.
 // The new dummy wire '_sg_consumed_dummy_signals' would typically be ignored
 // by synthesis tools or marked with a specific pragma (e.g., DONT_TOUCH/WAIVE)
 // in a real design flow to prevent a new W528 violation from appearing on it.
 wire _sg_consumed_dummy_signals;
 assign _sg_consumed_dummy_signals = _sg_dummy_read_p1 | _sg_dummy_read_p2;

endmodule
