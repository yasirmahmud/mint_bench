module top_module;
  // Instantiating sub_module and attempting to assign an aggregate literal
  // to the scalar parameter 'P'. This is an incompatible connection.
  sub_module #(.P('{1, 2})) inst_sub ();
endmodule
