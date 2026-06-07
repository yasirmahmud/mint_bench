module test19(input logic [15:0] in_bus, output logic [7:0] out_byte);
  assign out_byte = in_bus[4 :+ 8];
endmodule
