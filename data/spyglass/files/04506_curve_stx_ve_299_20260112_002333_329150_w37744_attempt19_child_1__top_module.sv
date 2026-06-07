module top_module;
  // Instantiating sub_module and assigning an aggregate literal to parameter 'P'.
  // This connection is now compatible, resolving the previous type mismatch error.
  sub_module #(.P('{1, 2})) inst_sub ();
endmodule
