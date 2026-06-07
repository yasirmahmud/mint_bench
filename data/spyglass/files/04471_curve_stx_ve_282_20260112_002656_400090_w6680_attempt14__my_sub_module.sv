module my_sub_module (
  input  [7:0] existing_in_a,
  input  [7:0] existing_in_b,
  output [7:0] existing_out_a
);
  assign existing_out_a = existing_in_a + existing_in_b;
endmodule
