module test14;
  `define LONG_STRING "This is a very long string that needs to be \

  continued on the next line."
  initial $display(`LONG_STRING);
endmodule
