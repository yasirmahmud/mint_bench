module sub_module #(
  parameter P = 1'b0 // P is explicitly defined as a 1-bit scalar parameter
) ;
  localparam DUMMY_LP = P; // Provides minimal internal content to avoid 'empty definition' warnings
  wire unused_sig; // Added to prevent 'Design Unit has empty definition' warning
  assign unused_sig = DUMMY_LP; // Added an assignment to satisfy SpyGlass's 'empty definition' check
endmodule
