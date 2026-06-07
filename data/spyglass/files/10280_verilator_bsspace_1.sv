module test1;
  `define MY_MACRO 10 \

  logic [7:0] data;
  assign data = `MY_MACRO;
endmodule
