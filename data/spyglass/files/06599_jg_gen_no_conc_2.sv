module top_gen_no_conc_2 (
  input wire in_a,
  output wire out_b
);

  assign out_b = in_a;

  generate
    // This generate block does not contain a conditional construct
    // and will trigger GEN_NO_CONC.
    wire internal_wire;
    assign internal_wire = in_a;
  endgenerate

endmodule
