module test3;
  wire [31:0] bus;
  wire [7:0] sub_bus;
  assign sub_bus = bus[16 :+ 8];
endmodule
