module implicit_assign_example (
  output out_val
);
  wire my_implicit_wire; // Explicitly declare the wire to resolve STX_VE_606
  assign out_val = my_implicit_wire;
endmodule
