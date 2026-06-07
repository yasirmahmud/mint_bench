module sub_module (
);
  parameter P = 0;
  localparam P_copy = P; // Added to prevent 'empty definition' violation
endmodule
