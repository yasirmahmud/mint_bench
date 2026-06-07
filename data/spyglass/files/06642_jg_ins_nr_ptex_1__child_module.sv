module child_module (
  input [3:0] in_data,
  output out_flag
);
  assign out_flag = (in_data == 4'd5);
endmodule
