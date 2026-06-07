module test11(input logic [7:0] in_val, output logic [3:0] out_val);
  assign out_val = in_val[2 :+ 4];
endmodule
