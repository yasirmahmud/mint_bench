module test4(output logic [7:0] out_data);
  logic [15:0] source;
  assign out_data = source[0 +: 8];
endmodule
