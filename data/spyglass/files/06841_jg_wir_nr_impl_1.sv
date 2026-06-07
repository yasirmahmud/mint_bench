module implicit_assign_example (
  output out_val
);
  assign out_val = my_implicit_wire; // my_implicit_wire is implicitly declared
endmodule
