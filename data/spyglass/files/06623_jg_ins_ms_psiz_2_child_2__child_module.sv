module child_module (
  input in_data,
  output [2:0] out_result
);
  assign out_result = {in_data, in_data, in_data};
endmodule
