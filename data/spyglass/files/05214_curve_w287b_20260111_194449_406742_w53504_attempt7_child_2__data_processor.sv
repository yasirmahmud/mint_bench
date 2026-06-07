module data_processor (
  input  a_in,
  output out_x,
  output out_y
);
  assign out_x = ~a_in;
  assign out_y = a_in;
endmodule
