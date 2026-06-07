module rep_large_constant_2 ();
  wire [63:0] another_large_vector;
  assign another_large_vector = {64{1'b0}};
endmodule
