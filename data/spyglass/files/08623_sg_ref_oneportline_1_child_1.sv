module OnePortLine_ex1(p1, p2);
 input p1, p2;

 // W240: Input declared but not read. Add dummy reads to fix this violation.
 // This logic is added solely to resolve linting violations and does not alter
 // the design's original unspecified functional behavior.
 wire _sg_dummy_read_p1;
 wire _sg_dummy_read_p2;

 assign _sg_dummy_read_p1 = p1;
 assign _sg_dummy_read_p2 = p2;
 endmodule
