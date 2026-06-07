module sub_module (
);
  parameter P = 0;
  localparam P_copy = P;
  wire dummy_signal; // Added to prevent 'empty definition' violation
endmodule
