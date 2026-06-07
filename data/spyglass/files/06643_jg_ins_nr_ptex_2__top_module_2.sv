module top_module_2 ();
  wire result;

  sub_mod u_sub (
    .a(1'b1),
    .b(0),
    .c(result)
  );
endmodule
