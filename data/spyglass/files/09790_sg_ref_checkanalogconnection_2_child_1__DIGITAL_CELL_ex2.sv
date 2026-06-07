module DIGITAL_CELL_ex2 (input A);
  wire dummy_A_read; // Added to resolve 'Design Unit ... has empty definition' and 'Input 'A' declared but not read.'
  assign dummy_A_read = A;
endmodule
