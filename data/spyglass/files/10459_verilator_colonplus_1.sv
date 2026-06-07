module test1;
  logic [7:0] data_in;
  logic [3:0] part;
  assign part = data_in[2 :+ 4];
endmodule
