module sub_ex2 (input [4:0] in_port, output [4:0] dummy_out);
  assign dummy_out = in_port; // Added to resolve 'empty definition' and 'input not read' warnings
endmodule
