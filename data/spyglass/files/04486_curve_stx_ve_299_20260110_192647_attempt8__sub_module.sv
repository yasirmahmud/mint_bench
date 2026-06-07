module sub_module #(
  parameter P = 1'b0 // P is explicitly defined as a 1-bit scalar parameter
) ;
  localparam DUMMY_LP = P; // Provides minimal internal content to avoid 'empty definition' warnings
endmodule
