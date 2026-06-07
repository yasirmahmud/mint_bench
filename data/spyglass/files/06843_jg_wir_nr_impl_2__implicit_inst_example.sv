module implicit_inst_example ();
  sub_mod u_sub (
    .a(another_implicit_wire) // another_implicit_wire is implicitly declared
  );
endmodule
